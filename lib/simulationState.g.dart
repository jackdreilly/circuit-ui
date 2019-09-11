// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulationState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulationState _$SimulationStateFromJson(Map<String, dynamic> json) {
  return SimulationState(
    Flags.fromJson(json['flags'] as Map<String, dynamic>),
    RamData.fromJson(json['ram'] as Map<String, dynamic>),
    (json['registers'] as List).map((e) => e as int).toList(),
    json['iar'] as int,
    Instruction.fromJson(json['ir'] as Map<String, dynamic>),
    Steps.fromJson(json['steps'] as Map<String, dynamic>),
    Instruction.fromJson(json['input'] as Map<String, dynamic>),
    json['output'] as int,
    Instruction.fromJson(json['bus'] as Map<String, dynamic>),
    (json['enablers'] as List).map((e) => e as String).toSet(),
    (json['selectors'] as List).map((e) => e as String).toSet(),
  );
}

Map<String, dynamic> _$SimulationStateToJson(SimulationState instance) =>
    <String, dynamic>{
      'flags': instance.flags,
      'ram': instance.ram,
      'registers': instance.registers,
      'iar': instance.iar,
      'ir': instance.ir,
      'steps': instance.steps,
      'input': instance.input,
      'bus': instance.bus,
      'output': instance.output,
      'enablers': instance.enablers.toList(),
      'selectors': instance.selectors.toList(),
    };
