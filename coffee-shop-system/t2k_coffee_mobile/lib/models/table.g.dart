// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CafeTable _$CafeTableFromJson(Map<String, dynamic> json) => CafeTable(
  idTable: (json['idTable'] as num?)?.toInt(),
  tableName: json['tableName'] as String?,
  status: json['status'] as String?,
);

Map<String, dynamic> _$CafeTableToJson(CafeTable instance) => <String, dynamic>{
  'idTable': instance.idTable,
  'tableName': instance.tableName,
  'status': instance.status,
};
