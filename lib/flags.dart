import 'package:json_annotation/json_annotation.dart';

part 'flags.g.dart';

@JsonSerializable(nullable: false)
class Flags {
  final Map<String, bool> values;

  Flags(this.values);
  factory Flags.fromJson(Map<String, dynamic> json) => _$FlagsFromJson(json);
}
