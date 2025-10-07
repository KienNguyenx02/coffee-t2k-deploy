// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  idProduct: (json['idProduct'] as num?)?.toInt(),
  productName: json['productName'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  description: json['description'] as String?,
  image: json['image'] as String?,
  isAvailable: json['isAvailable'] as bool?,
  categoryId: (json['categoryId'] as num?)?.toInt(),
  categoryName: json['categoryName'] as String?,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'idProduct': instance.idProduct,
  'productName': instance.productName,
  'price': instance.price,
  'description': instance.description,
  'image': instance.image,
  'isAvailable': instance.isAvailable,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
};
