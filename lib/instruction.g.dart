// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Instruction _$InstructionFromJson(Map<String, dynamic> json) {
  return Instruction(
    json['value'] as int,
    json['interpretation'] as String,
  );
}

Map<String, dynamic> _$InstructionToJson(Instruction instance) =>
    <String, dynamic>{
      'value': instance.value,
      'interpretation': instance.interpretation,
    };
