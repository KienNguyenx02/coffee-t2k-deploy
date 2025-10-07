// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) =>
    WebSocketMessage(
      type: json['type'] as String?,
      data: json['data'],
      timestamp: json['timestamp'] as String?,
      userId: json['userId'] as String?,
      sessionId: json['sessionId'] as String?,
    );

Map<String, dynamic> _$WebSocketMessageToJson(WebSocketMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'timestamp': instance.timestamp,
      'userId': instance.userId,
      'sessionId': instance.sessionId,
    };

OrderNotification _$OrderNotificationFromJson(Map<String, dynamic> json) =>
    OrderNotification(
      notificationType: json['notificationType'] as String?,
      order: json['order'],
      message: json['message'] as String?,
      priority: json['priority'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$OrderNotificationToJson(OrderNotification instance) =>
    <String, dynamic>{
      'notificationType': instance.notificationType,
      'order': instance.order,
      'message': instance.message,
      'priority': instance.priority,
      'timestamp': instance.timestamp,
    };

WebSocketRegistration _$WebSocketRegistrationFromJson(
  Map<String, dynamic> json,
) => WebSocketRegistration(
  userId: json['userId'] as String,
  userType: json['userType'] as String,
  deviceId: json['deviceId'] as String?,
  deviceName: json['deviceName'] as String?,
);

Map<String, dynamic> _$WebSocketRegistrationToJson(
  WebSocketRegistration instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'userType': instance.userType,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
};

WebSocketStats _$WebSocketStatsFromJson(Map<String, dynamic> json) =>
    WebSocketStats(
      activeStaffCount: (json['activeStaffCount'] as num?)?.toInt(),
      activeCustomerCount: (json['activeCustomerCount'] as num?)?.toInt(),
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$WebSocketStatsToJson(WebSocketStats instance) =>
    <String, dynamic>{
      'activeStaffCount': instance.activeStaffCount,
      'activeCustomerCount': instance.activeCustomerCount,
      'timestamp': instance.timestamp,
    };
