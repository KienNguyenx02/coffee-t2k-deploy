import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../models/websocket_message.dart';
import '../utils/api_config.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _isConnecting = false;
  bool _isConnected = false;
  String? _userId;
  String? _userType;
  String? _deviceId;

  // Stream controllers for different message types
  final StreamController<WebSocketMessage> _messageController =
      StreamController<WebSocketMessage>.broadcast();
  final StreamController<OrderNotification> _orderNotificationController =
      StreamController<OrderNotification>.broadcast();
  final StreamController<String> _connectionStatusController =
      StreamController<String>.broadcast();

  // Getters
  bool get isConnected => _isConnected;
  bool get isConnecting => _isConnecting;
  Stream<WebSocketMessage> get messageStream => _messageController.stream;
  Stream<OrderNotification> get orderNotificationStream =>
      _orderNotificationController.stream;
  Stream<String> get connectionStatusStream =>
      _connectionStatusController.stream;

  // Connect to WebSocket
  Future<bool> connect({
    required String userId,
    required String userType,
    String? deviceId,
  }) async {
    if (_isConnecting || _isConnected) {
      print('WebSocket already connecting/connected');
      return _isConnected;
    }

    _userId = userId;
    _userType = userType;
    _deviceId = deviceId;
    _isConnecting = true;
    _connectionStatusController.add('connecting');

    try {
      final uri = Uri.parse(ApiConfig.wsUrl);
      print('Connecting to WebSocket: $uri');
      _channel = WebSocketChannel.connect(uri);

      // Listen to incoming messages
      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnection,
      );

      // Wait for connection to be established
      await Future.delayed(Duration(milliseconds: 1000));

      if (_channel != null) {
        _isConnected = true;
        _isConnecting = false;
        _reconnectAttempts = 0;
        _connectionStatusController.add('connected');
        print('WebSocket connected successfully');

        // Register user with server
        await _registerUser();

        // Start heartbeat
        _startHeartbeat();

        return true;
      }
    } catch (e) {
      print('WebSocket connection failed: $e');
      _handleError(e);
    }

    _isConnecting = false;
    _connectionStatusController.add('disconnected');
    return false;
  }

  // Disconnect from WebSocket
  Future<void> disconnect() async {
    _stopHeartbeat();
    _stopReconnectTimer();

    if (_channel != null) {
      // Send disconnect message
      await _sendMessage(ApiConfig.disconnectDestination, {
        'userId': _userId,
        'userType': _userType,
      });

      await _channel!.sink.close(status.normalClosure);
      _channel = null;
    }

    _isConnected = false;
    _isConnecting = false;
    _connectionStatusController.add('disconnected');
  }

  // Handle incoming messages
  void _handleMessage(dynamic message) {
    try {
      print('Received WebSocket message: $message');
      final data = json.decode(message);
      final wsMessage = WebSocketMessage.fromJson(data);

      _messageController.add(wsMessage);

      // Handle specific message types
      if (wsMessage.type == 'ORDER_NOTIFICATION' && wsMessage.data != null) {
        print('Received ORDER_NOTIFICATION: ${wsMessage.data}');
        final notification = OrderNotification.fromJson(wsMessage.data);
        _orderNotificationController.add(notification);
      }
    } catch (e) {
      print('Error handling WebSocket message: $e');
    }
  }

  // Handle WebSocket errors
  void _handleError(dynamic error) {
    print('WebSocket error: $error');
    _isConnected = false;
    _isConnecting = false;
    _connectionStatusController.add('error');

    // Attempt to reconnect
    _attemptReconnect();
  }

  // Handle disconnection
  void _handleDisconnection() {
    print('WebSocket disconnected');
    _isConnected = false;
    _isConnecting = false;
    _connectionStatusController.add('disconnected');

    // Attempt to reconnect
    _attemptReconnect();
  }

  // Attempt to reconnect
  void _attemptReconnect() {
    if (_reconnectAttempts >= ApiConfig.maxReconnectAttempts) {
      print('Max reconnection attempts reached');
      _connectionStatusController.add('failed');
      return;
    }

    _stopReconnectTimer();
    _reconnectAttempts++;

    print(
      'Attempting to reconnect (${_reconnectAttempts}/${ApiConfig.maxReconnectAttempts})',
    );

    _reconnectTimer = Timer(
      Duration(milliseconds: ApiConfig.reconnectDelayMs * _reconnectAttempts),
      () {
        if (_userId != null && _userType != null) {
          connect(userId: _userId!, userType: _userType!, deviceId: _deviceId);
        }
      },
    );
  }

  // Register user with server
  Future<void> _registerUser() async {
    if (_userId != null && _userType != null) {
      await _sendMessage(ApiConfig.registerDestination, {
        'userId': _userId,
        'userType': _userType,
        'deviceId': _deviceId,
      });

      // Subscribe to relevant topics based on user type
      if (_userType == 'STAFF' || _userType == 'ADMIN') {
        // Staff should listen to staff orders topic
        await _sendMessage('/topic/staff/orders', {
          'action': 'subscribe',
          'userId': _userId,
          'userType': _userType,
        });
      }

      // All users should listen to notifications
      await _sendMessage('/queue/notifications', {
        'action': 'subscribe',
        'userId': _userId,
        'userType': _userType,
      });
    }
  }

  // Send message to server
  Future<void> _sendMessage(
    String destination,
    Map<String, dynamic> data,
  ) async {
    if (_channel != null && _isConnected) {
      try {
        final message = json.encode(data);
        _channel!.sink.add(message);
      } catch (e) {
        print('Error sending WebSocket message: $e');
      }
    }
  }

  // Start heartbeat
  void _startHeartbeat() {
    _stopHeartbeat();
    _heartbeatTimer = Timer.periodic(
      Duration(milliseconds: ApiConfig.heartbeatIntervalMs),
      (timer) {
        if (_isConnected) {
          _sendMessage(ApiConfig.pingDestination, {
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          });
        }
      },
    );
  }

  // Stop heartbeat
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  // Stop reconnect timer
  void _stopReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  // Send order status update (for staff)
  Future<void> updateOrderStatus(int orderId, String status) async {
    await _sendMessage(ApiConfig.orderStatusDestination, {
      'orderId': orderId,
      'status': status,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Send staff ready notification
  Future<void> notifyStaffReady(String staffName) async {
    await _sendMessage(ApiConfig.staffReadyDestination, {
      'staffId': _userId,
      'staffName': staffName,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Request order tracking (for customers)
  Future<void> trackOrder(int orderId) async {
    await _sendMessage(ApiConfig.orderTrackDestination, {
      'orderId': orderId,
      'customerId': _userId,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  // Dispose resources
  void dispose() {
    disconnect();
    _messageController.close();
    _orderNotificationController.close();
    _connectionStatusController.close();
  }
}
