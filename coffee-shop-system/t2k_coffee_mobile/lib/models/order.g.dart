// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  idOrder: (json['idOrder'] as num?)?.toInt(),
  tableId: (json['tableId'] as num?)?.toInt(),
  tableNumber: json['tableNumber'] as String?,
  location: json['location'] as String?,
  quantity: (json['quantity'] as num?)?.toInt(),
  orderTime: json['orderTime'] == null
      ? null
      : DateTime.parse(json['orderTime'] as String),
  totalAmount: (json['totalAmount'] as num?)?.toDouble(),
  note: json['note'] as String?,
  status: json['status'] as String?,
  accountId: (json['accountId'] as num?)?.toInt(),
  promotionId: (json['promotionId'] as num?)?.toInt(),
  orderDetails: (json['orderDetails'] as List<dynamic>?)
      ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
      .toList(),
  payment: json['payment'] == null
      ? null
      : Payment.fromJson(json['payment'] as Map<String, dynamic>),
  account: json['account'] == null
      ? null
      : User.fromJson(json['account'] as Map<String, dynamic>),
  table: json['table'] == null
      ? null
      : Table.fromJson(json['table'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'idOrder': instance.idOrder,
  'tableId': instance.tableId,
  'tableNumber': instance.tableNumber,
  'location': instance.location,
  'quantity': instance.quantity,
  'orderTime': instance.orderTime?.toIso8601String(),
  'totalAmount': instance.totalAmount,
  'note': instance.note,
  'status': instance.status,
  'accountId': instance.accountId,
  'promotionId': instance.promotionId,
  'orderDetails': instance.orderDetails,
  'payment': instance.payment,
  'account': instance.account,
  'table': instance.table,
};

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) => OrderDetail(
  productId: (json['productId'] as num?)?.toInt(),
  orderId: (json['orderId'] as num?)?.toInt(),
  product: json['product'] == null
      ? null
      : Product.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num?)?.toInt(),
  unitPrice: (json['unitPrice'] as num?)?.toDouble(),
  subtotal: (json['subtotal'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'orderId': instance.orderId,
      'product': instance.product,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'subtotal': instance.subtotal,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  idPayment: (json['idPayment'] as num?)?.toInt(),
  orderId: (json['orderId'] as num?)?.toInt(),
  createAt: json['createAt'] == null
      ? null
      : DateTime.parse(json['createAt'] as String),
  paymentMethod: json['paymentMethod'] as String?,
  paymentStatus: json['paymentStatus'] as String?,
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'idPayment': instance.idPayment,
  'orderId': instance.orderId,
  'createAt': instance.createAt?.toIso8601String(),
  'paymentMethod': instance.paymentMethod,
  'paymentStatus': instance.paymentStatus,
};

Table _$TableFromJson(Map<String, dynamic> json) => Table(
  idTable: (json['idTable'] as num?)?.toInt(),
  status: json['status'] as String?,
  capacity: (json['capacity'] as num?)?.toInt(),
  location: json['location'] as String?,
  tableNumber: (json['tableNumber'] as num?)?.toInt(),
);

Map<String, dynamic> _$TableToJson(Table instance) => <String, dynamic>{
  'idTable': instance.idTable,
  'status': instance.status,
  'capacity': instance.capacity,
  'location': instance.location,
  'tableNumber': instance.tableNumber,
};
