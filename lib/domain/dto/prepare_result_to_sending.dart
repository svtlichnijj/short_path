import 'package:json_annotation/json_annotation.dart';

import 'package:short_path/domain/dto/results_to_sending.dart';

part 'prepare_result_to_sending.g.dart';

@JsonSerializable(explicitToJson: true)
class PrepareResultToSending {
  @JsonKey(required: true)
  String id;

  @JsonKey(required: true)
  ResultToSending result;

  PrepareResultToSending({
    required this.id,
    required this.result,
  });

  factory PrepareResultToSending.fromJson(Map<String, dynamic> json) => _$PrepareResultToSendingFromJson(json);
  // PrepareResultToSending.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       result = json['result'];

  Map<String, dynamic> toJson() => _$PrepareResultToSendingToJson(this);
  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'result': result.toJson(),
  //     };
}