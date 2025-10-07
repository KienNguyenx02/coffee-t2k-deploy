import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
import 'product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int? idOrder;
  final int? tableId;
  final String? tableNumber;
  final String? location;
  final int? quantity;
  final DateTime? orderTime;
  final double? totalAmount;
  final String? note;
  final String? status;
  final int? accountId;
  final int? promotionId;
  final List<OrderDetail>? orderDetails;
  final Payment? payment;
  final User? account;
  final Table? table;

  Order({
    this.idOrder,
    this.tableId,
    this.tableNumber,
    this.location,
    this.quantity,
    this.orderTime,
    this.totalAmount,
    this.note,
    this.status,
    this.accountId,
    this.promotionId,
    this.orderDetails,
    this.payment,
    this.account,
    this.table,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Order copyWith({
    int? idOrder,
    int? tableId,
    String? tableNumber,
    String? location,
    int? quantity,
    DateTime? orderTime,
    double? totalAmount,
    String? note,
    String? status,
    int? accountId,
    int? promotionId,
    List<OrderDetail>? orderDetails,
    Payment? payment,
    User? account,
    Table? table,
  }) {
    return Order(
      idOrder: idOrder ?? this.idOrder,
      tableId: tableId ?? this.tableId,
      tableNumber: tableNumber ?? this.tableNumber,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
      orderTime: orderTime ?? this.orderTime,
      totalAmount: totalAmount ?? this.totalAmount,
      note: note ?? this.note,
      status: status ?? this.status,
      accountId: accountId ?? this.accountId,
      promotionId: promotionId ?? this.promotionId,
      orderDetails: orderDetails ?? this.orderDetails,
      payment: payment ?? this.payment,
      account: account ?? this.account,
      table: table ?? this.table,
    );
  }

  String get formattedTotalAmount {
    if (totalAmount == null) return '0 đ';
    return '${totalAmount!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }

  String get statusText {
    switch (status?.toLowerCase()) {
      case 'processing':
        return 'Đang xử lý';
      case 'preparing':
        return 'Đang chế biến';
      case 'ready':
        return 'Sẵn sàng';
      case 'completed':
        return 'Hoàn thành';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status ?? 'Không xác định';
    }
  }

  bool get isProcessing => status?.toLowerCase() == 'processing';
  bool get isPreparing => status?.toLowerCase() == 'preparing';
  bool get isReady => status?.toLowerCase() == 'ready';
  bool get isCompleted => status?.toLowerCase() == 'completed';
  bool get isCancelled => status?.toLowerCase() == 'cancelled';

  String get displayLocation {
    // Kiểm tra nếu có table object (dine-in)
    if (table != null && table!.tableNumber != null) {
      String locationText = 'Bàn ${table!.tableNumber}';
      if (table!.location != null && table!.location!.isNotEmpty) {
        locationText += ' (${table!.location})';
      }
      return locationText;
    }

    // Nếu không có table, mặc định là takeaway
    return 'Mang đi';
  }
}

@JsonSerializable()
class OrderDetail {
  final int? productId;
  final int? orderId;
  final Product? product;
  final int? quantity;
  final double? unitPrice;
  final double? subtotal;

  OrderDetail({
    this.productId,
    this.orderId,
    this.product,
    this.quantity,
    this.unitPrice,
    this.subtotal,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

  String get formattedUnitPrice {
    if (unitPrice == null || unitPrice == 0) return '0 đ';
    return '${unitPrice!.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }

  String get formattedSubtotal {
    double calculatedSubtotal = 0;

    // Nếu subtotal null, tính từ unitPrice * quantity
    if (subtotal == null || subtotal == 0) {
      if (unitPrice != null && quantity != null) {
        calculatedSubtotal = unitPrice! * quantity!;
      }
    } else {
      calculatedSubtotal = subtotal!;
    }

    if (calculatedSubtotal == 0) return '0 đ';
    return '${calculatedSubtotal.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }
}

@JsonSerializable()
class Payment {
  final int? idPayment;
  final int? orderId;
  final DateTime? createAt;
  final String? paymentMethod;
  final String? paymentStatus;

  Payment({
    this.idPayment,
    this.orderId,
    this.createAt,
    this.paymentMethod,
    this.paymentStatus,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  String get paymentMethodText {
    switch (paymentMethod?.toLowerCase()) {
      case 'cash':
        return 'Tiền mặt';
      case 'transfer':
        return 'Chuyển khoản';
      case 'card':
        return 'Thẻ';
      default:
        return paymentMethod ?? 'Không xác định';
    }
  }

  String get paymentStatusText {
    switch (paymentStatus?.toLowerCase()) {
      case 'pending':
        return 'Chờ thanh toán';
      case 'completed':
        return 'Đã thanh toán';
      case 'failed':
        return 'Thanh toán thất bại';
      default:
        return paymentStatus ?? 'Không xác định';
    }
  }

  bool get isCompleted => paymentStatus?.toLowerCase() == 'completed';
}

@JsonSerializable()
class Table {
  final int? idTable;
  final String? status;
  final int? capacity;
  final String? location;
  final int? tableNumber;

  Table({
    this.idTable,
    this.status,
    this.capacity,
    this.location,
    this.tableNumber,
  });

  factory Table.fromJson(Map<String, dynamic> json) => _$TableFromJson(json);
  Map<String, dynamic> toJson() => _$TableToJson(this);

  String get statusText {
    switch (status?.toLowerCase()) {
      case 'available':
        return 'Trống';
      case 'occupied':
        return 'Đang phục vụ';
      case 'reserved':
        return 'Đã đặt';
      default:
        return status ?? 'Không xác định';
    }
  }

  bool get isAvailable => status?.toLowerCase() == 'available';
  bool get isOccupied => status?.toLowerCase() == 'occupied';
}
