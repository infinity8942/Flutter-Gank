// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GankList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GankList _$GankListFromJson(Map<String, dynamic> json) {
  return GankList(
      json['error'] as bool,
      (json['results'] as List)
          ?.map((e) =>
              e == null ? null : GankItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$GankListToJson(GankList instance) =>
    <String, dynamic>{'error': instance.error, 'results': instance.results};
