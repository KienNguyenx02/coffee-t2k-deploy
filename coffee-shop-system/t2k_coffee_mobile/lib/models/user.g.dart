// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  idAccount: (json['idAccount'] as num?)?.toInt(),
  userName: json['userName'] as String?,
  fullName: json['fullName'] as String?,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  image: json['image'] as String?,
  role: json['role'] as String?,
  rewardPoints: (json['rewardPoints'] as num?)?.toInt(),
  status: json['status'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'idAccount': instance.idAccount,
  'userName': instance.userName,
  'fullName': instance.fullName,
  'phone': instance.phone,
  'address': instance.address,
  'image': instance.image,
  'role': instance.role,
  'rewardPoints': instance.rewardPoints,
  'status': instance.status,
};
