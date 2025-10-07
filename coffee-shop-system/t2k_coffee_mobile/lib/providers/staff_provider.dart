import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/websocket_message.dart';
import '../services/api_service.dart';
import '../services/websocket_service.dart';
import '../services/speech_service.dart';

class StaffProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final WebSocketService _webSocketService = WebSocketService();
  final SpeechService _speechService = SpeechService();

  List<Order> _allOrders = [];
  bool _isLoading = false;
  String? _error;
  bool _isConnected = false;
  String? _staffName;

  // Getters
  List<Order> get allOrders => _allOrders;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isConnected => _isConnected;
  String? get staffName => _staffName;

  // Order counts by status
  int get newOrdersCount =>
      _allOrders.where((order) => order.isProcessing).length;
  int get preparingOrdersCount =>
      _allOrders.where((order) => order.isPreparing).length;
  int get readyOrdersCount => _allOrders.where((order) => order.isReady).length;
  int get completedOrdersCount =>
      _allOrders.where((order) => order.isCompleted).length;
  int get cancelledOrdersCount =>
      _allOrders.where((order) => order.isCancelled).length;

  // Initialize staff services
  Future<void> initialize() async {
    _setLoading(true);

    try {
      // Initialize speech service
      await _speechService.initialize();

      // Load initial orders
      await _loadOrders();

      // Connect to WebSocket
      await _connectWebSocket();

      _clearError();
    } catch (e) {
      _setError('Failed to initialize: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load orders from API
  Future<void> _loadOrders() async {
    try {
      final orders = await _apiService.getOrders();
      _allOrders = orders;
      notifyListeners();
    } catch (e) {
      _setError('Failed to load orders: $e');
    }
  }

  // Connect to WebSocket
  Future<void> _connectWebSocket() async {
    try {
      // Get current user info
      final currentUser = _apiService.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }

      _staffName = currentUser.fullName ?? 'Staff';

      // Connect to WebSocket
      final connected = await _webSocketService.connect(
        userId: currentUser.idAccount.toString(),
        userType: 'STAFF',
        deviceId: 'mobile_device',
      );

      if (connected) {
        _isConnected = true;

        // Listen to order notifications
        _webSocketService.orderNotificationStream.listen(
          _handleOrderNotification,
        );

        // Listen to connection status
        _webSocketService.connectionStatusStream.listen(
          _handleConnectionStatus,
        );

        notifyListeners();
      }
    } catch (e) {
      _setError('Failed to connect to WebSocket: $e');
    }
  }

  // Handle order notifications
  void _handleOrderNotification(OrderNotification notification) {
    if (notification.isNewOrder) {
      // Add new order to list
      final order = Order.fromJson(notification.order);
      _allOrders.insert(0, order);

      // Announce new order with speech
      _speechService.announceNewOrder(
        orderId: order.idOrder!,
        tableNumber: order.tableNumber,
        location: order.location,
        totalAmount: order.totalAmount,
      );

      notifyListeners();
    } else if (notification.isOrderUpdated) {
      // Update existing order
      final updatedOrder = Order.fromJson(notification.order);
      final index = _allOrders.indexWhere(
        (order) => order.idOrder == updatedOrder.idOrder,
      );

      if (index >= 0) {
        _allOrders[index] = updatedOrder;
        notifyListeners();
      }
    }
  }

  // Handle connection status changes
  void _handleConnectionStatus(String status) {
    _isConnected = status == 'connected';
    notifyListeners();
  }

  // Update order status
  Future<void> updateOrderStatus(int orderId, String status) async {
    try {
      final updatedOrder = await _apiService.updateOrderStatus(orderId, status);

      // Update local order list
      final index = _allOrders.indexWhere((order) => order.idOrder == orderId);
      if (index >= 0) {
        _allOrders[index] = updatedOrder;
        notifyListeners();
      }

      // Send WebSocket update
      await _webSocketService.updateOrderStatus(orderId, status);
    } catch (e) {
      _setError('Failed to update order status: $e');
    }
  }

  // Notify staff is ready
  Future<void> notifyReady() async {
    try {
      await _webSocketService.notifyStaffReady(_staffName ?? 'Staff');

      // Show success message
      _clearError();
    } catch (e) {
      _setError('Failed to notify ready status: $e');
    }
  }

  // Get orders by status
  List<Order> getOrdersByStatus(String status) {
    return _allOrders
        .where((order) => order.status?.toLowerCase() == status.toLowerCase())
        .toList();
  }

  // Refresh orders
  Future<void> refreshOrders() async {
    await _loadOrders();
  }

  // Test speech
  Future<void> testSpeech() async {
    await _speechService.testSpeech();
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  void clearError() {
    _clearError();
    notifyListeners();
  }

  // Dispose resources
  @override
  void dispose() {
    _webSocketService.dispose();
    _speechService.dispose();
    super.dispose();
  }
}
