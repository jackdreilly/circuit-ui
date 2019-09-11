import 'package:json_annotation/json_annotation.dart';
import 'flags.dart';
import 'instruction.dart';
import 'ramData.dart';
import 'steps.dart';

part 'simulationState.g.dart';

@JsonSerializable(nullable: false)
class SimulationState {
  final Flags flags;
  final RamData ram;
  final List<int> registers;
  final int iar;
  final Instruction ir;
  final Steps steps;

  final Instruction input;
  final Instruction bus;

  final int output;

  final Set<String> enablers;
  final Set<String> selectors;

  SimulationState(
      this.flags,
      this.ram,
      this.registers,
      this.iar,
      this.ir,
      this.steps,
      this.input,
      this.output,
      this.bus,
      this.enablers,
      this.selectors);

  factory SimulationState.fromJson(Map<String, dynamic> json) =>
      _$SimulationStateFromJson(json);

  factory SimulationState.empty() {
    return SimulationState(
      Flags({}),
      RamData(data: [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
      ]),
      [0, 0, 0, 0],
      0,
      Instruction(0, ""),
      Steps([false, false, false, false, false, false]),
      Instruction(0, ""),
      0,
      Instruction(0, ""),
      {},
      {},
    );
  }
}
