// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  productId: (json['productId'] as num).toInt(),
  productName: json['productName'] as String,
  basePrice: (json['basePrice'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
  quantity: (json['quantity'] as num).toInt(),
  variants: ProductVariants.fromJson(json['variants'] as Map<String, dynamic>),
  totalPrice: (json['totalPrice'] as num).toDouble(),
);

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
  'productId': instance.productId,
  'productName': instance.productName,
  'basePrice': instance.basePrice,
  'price': instance.price,
  'quantity': instance.quantity,
  'variants': instance.variants,
  'totalPrice': instance.totalPrice,
};

ProductVariants _$ProductVariantsFromJson(Map<String, dynamic> json) =>
    ProductVariants(
      size: json['size'] as String?,
      ice: json['ice'] as String?,
      sugar: json['sugar'] as String?,
      toppings: (json['toppings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductVariantsToJson(ProductVariants instance) =>
    <String, dynamic>{
      'size': instance.size,
      'ice': instance.ice,
      'sugar': instance.sugar,
      'toppings': instance.toppings,
    };
