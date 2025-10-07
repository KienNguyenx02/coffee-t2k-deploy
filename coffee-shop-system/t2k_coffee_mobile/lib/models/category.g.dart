// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  idCategory: (json['idCategory'] as num?)?.toInt(),
  categoryName: json['categoryName'] as String?,
  description: json['description'] as String?,
  products: (json['products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'idCategory': instance.idCategory,
  'categoryName': instance.categoryName,
  'description': instance.description,
  'products': instance.products,
};
