// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'steps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Steps _$StepsFromJson(Map<String, dynamic> json) {
  return Steps(
    (json['steps'] as List).map((e) => e as bool).toList(),
  );
}

Map<String, dynamic> _$StepsToJson(Steps instance) => <String, dynamic>{
      'steps': instance.steps,
    };
