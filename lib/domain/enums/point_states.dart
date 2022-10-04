// import 'dart:html';

/*
import 'package:json_annotation/json_annotation.dart';

part 'point_states.g.dart';

@JsonSerializable()
 */

// class PointStates extends DataTransferItem
enum PointStates {
// class PointStates {
  // @JsonKey(required: true, defaultValue: true)
  // static const bool passing = true;
  passing(true),

  // @JsonKey(required: true, defaultValue: false)
  // static const bool impassable = false;
  impassable(false);

  // can add more properties or getters/methods if needed
  final bool value;

  // can use named parameters if you want
  const PointStates(this.value);
  /*
  PointStates();

  factory PointStates.fromJson(Map<String, dynamic> json) => _$PointStatesFromJson(json);

  Map<String, dynamic> toJson() => _$PointStatesToJson(this);
   */
}