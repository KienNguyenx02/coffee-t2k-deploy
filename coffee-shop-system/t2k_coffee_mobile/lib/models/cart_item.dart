import 'package:json_annotation/json_annotation.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final int productId;
  final String productName;
  final double basePrice;
  final double price;
  final int quantity;
  final ProductVariants variants;
  final double totalPrice;

  CartItem({
    required this.productId,
    required this.productName,
    required this.basePrice,
    required this.price,
    required this.quantity,
    required this.variants,
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  CartItem copyWith({
    int? productId,
    String? productName,
    double? basePrice,
    double? price,
    int? quantity,
    ProductVariants? variants,
    double? totalPrice,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      basePrice: basePrice ?? this.basePrice,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      variants: variants ?? this.variants,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  String get formattedTotalPrice {
    return '${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }

  String get formattedPrice {
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} đ';
  }

  String get variantDescription {
    List<String> descriptions = [];

    if (variants.size != null) {
      descriptions.add('Size: ${variants.size}');
    }

    if (variants.ice != null) {
      descriptions.add('Đá: ${variants.ice}%');
    }

    if (variants.sugar != null) {
      descriptions.add('Đường: ${variants.sugar}%');
    }

    if (variants.toppings != null && variants.toppings!.isNotEmpty) {
      descriptions.add('Topping: ${variants.toppings!.join(', ')}');
    }

    return descriptions.join(' • ');
  }

  bool get hasVariants {
    return variants.size != null ||
        variants.ice != null ||
        variants.sugar != null ||
        (variants.toppings != null && variants.toppings!.isNotEmpty);
  }
}

@JsonSerializable()
class ProductVariants {
  final String? size;
  final String? ice;
  final String? sugar;
  final List<String>? toppings;

  ProductVariants({this.size, this.ice, this.sugar, this.toppings});

  factory ProductVariants.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductVariantsToJson(this);

  ProductVariants copyWith({
    String? size,
    String? ice,
    String? sugar,
    List<String>? toppings,
  }) {
    return ProductVariants(
      size: size ?? this.size,
      ice: ice ?? this.ice,
      sugar: sugar ?? this.sugar,
      toppings: toppings ?? this.toppings,
    );
  }

  static ProductVariants get defaultVariants => ProductVariants(
    size: 'M',
    ice: 'Bình thường',
    sugar: 'Bình thường',
    toppings: [],
  );
}
