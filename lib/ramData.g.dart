// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ramData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RamData _$RamDataFromJson(Map<String, dynamic> json) {
  return RamData(
    data: (json['data'] as List)
        .map((e) => (e as List).map((e) => e as int).toList())
        .toList(),
  );
}

Map<String, dynamic> _$RamDataToJson(RamData instance) => <String, dynamic>{
      'data': instance.data,
    };
