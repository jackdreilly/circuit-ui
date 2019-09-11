import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ramData.g.dart';


@JsonSerializable(nullable: false)
class RamData {
  final List<List<int>> data;
  RamData({@required this.data});
  int nRows() {
    return data.length;
  }

  int nCols() {
    return data[0].length;
  }

  factory RamData.fromJson(Map<String, dynamic> json) => _$RamDataFromJson(json);
}