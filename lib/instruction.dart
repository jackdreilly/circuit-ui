
import 'package:json_annotation/json_annotation.dart';

part 'instruction.g.dart';

@JsonSerializable(nullable: false)
class Instruction {
  final int value;
  final String interpretation;

  Instruction(this.value, this.interpretation);
  factory Instruction.fromJson(Map<String, dynamic> json) => _$InstructionFromJson(json);
}