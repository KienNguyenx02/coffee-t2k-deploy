import 'package:json_annotation/json_annotation.dart';

part 'websocket_message.g.dart';

@JsonSerializable()
class WebSocketMessage {
  final String? type;
  final dynamic data;
  final String? timestamp;
  final String? userId;
  final String? sessionId;

  WebSocketMessage({
    this.type,
    this.data,
    this.timestamp,
    this.userId,
    this.sessionId,
  });

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);
  Map<String, dynamic> toJson() => _$WebSocketMessageToJson(this);
}

@JsonSerializable()
class OrderNotification {
  final String? notificationType;
  final dynamic order; // Will be parsed as Order object
  final String? message;
  final String? priority;
  final String? timestamp;

  OrderNotification({
    this.notificationType,
    this.order,
    this.message,
    this.priority,
    this.timestamp,
  });

  factory OrderNotification.fromJson(Map<String, dynamic> json) =>
      _$OrderNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$OrderNotificationToJson(this);

  bool get isHighPriority => priority?.toUpperCase() == 'HIGH';
  bool get isNewOrder => notificationType == 'NEW_ORDER';
  bool get isOrderUpdated => notificationType == 'ORDER_UPDATED';
  bool get isOrderCompleted => notificationType == 'ORDER_COMPLETED';
  bool get isOrderCancelled => notificationType == 'ORDER_CANCELLED';
}

@JsonSerializable()
class WebSocketRegistration {
  final String userId;
  final String userType;
  final String? deviceId;
  final String? deviceName;

  WebSocketRegistration({
    required this.userId,
    required this.userType,
    this.deviceId,
    this.deviceName,
  });

  factory WebSocketRegistration.fromJson(Map<String, dynamic> json) =>
      _$WebSocketRegistrationFromJson(json);
  Map<String, dynamic> toJson() => _$WebSocketRegistrationToJson(this);
}

@JsonSerializable()
class WebSocketStats {
  final int? activeStaffCount;
  final int? activeCustomerCount;
  final String? timestamp;

  WebSocketStats({
    this.activeStaffCount,
    this.activeCustomerCount,
    this.timestamp,
  });

  factory WebSocketStats.fromJson(Map<String, dynamic> json) =>
      _$WebSocketStatsFromJson(json);
  Map<String, dynamic> toJson() => _$WebSocketStatsToJson(this);
}
