import 'package:flutter_gank/models/GankItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'GankList.g.dart';

@JsonSerializable()
class GankList {
  @JsonKey(name: 'error')
  final bool error;
  final List<GankItem> results;

  GankList(this.error, this.results);

  factory GankList.fromJson(Map<String, dynamic> json) =>
      _$GankListFromJson(json);

  Map<String, dynamic> toJson() => _$GankListToJson(this);
}
