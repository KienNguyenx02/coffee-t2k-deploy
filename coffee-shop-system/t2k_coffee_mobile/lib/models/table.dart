import 'package:json_annotation/json_annotation.dart';

part 'table.g.dart';

@JsonSerializable()
class CafeTable {
  final int? idTable;
  final String? tableName;
  final String? status;

  CafeTable({this.idTable, this.tableName, this.status});

  factory CafeTable.fromJson(Map<String, dynamic> json) =>
      _$CafeTableFromJson(json);
  Map<String, dynamic> toJson() => _$CafeTableToJson(this);

  bool get isAvailable => status?.toLowerCase() == 'available';
  bool get isOccupied => status?.toLowerCase() == 'occupied';
}
