import 'package:json_annotation/json_annotation.dart';

part 'steps.g.dart';

@JsonSerializable(nullable: false)
class Steps {
  final List<bool> steps;

  int get step {
    for (var i = 0; i < steps.length; i++) {
      if (steps[i]) {
        return i;
      }
    }
    return -1;
  }

  Steps(this.steps);
  factory Steps.fromJson(Map<String, dynamic> json) => _$StepsFromJson(json);
}