import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/results_to_sending.dart';
import 'package:short_path/domain/models/field_path.dart';

class PrepareResultToSending {
  String id;
  ResultToSending result;

  PrepareResultToSending({
    required this.id,
    required this.result,
  });

  factory PrepareResultToSending.fromJson(Map<String, dynamic> json) => PrepareResultToSending(
    id: json['id'] as String,
    result: ResultToSending.fromJson(json['result'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'result': result.toJson(),
  };

  static Stream<List<PrepareResultToSending>> listFromLocalPathsPoints() async* {
    Map<String, FieldPath>? pathsPoints;

    while (pathsPoints == null) {
      pathsPoints = await LocalStorage.getPaths();
      await Future<void>.delayed(const Duration(seconds: 2));
      yield prepareResultsFromPathsPoints({});
    }

    yield prepareResultsFromPathsPoints(pathsPoints);
  }

  static List<PrepareResultToSending> prepareResultsFromPathsPoints(Map<String, FieldPath> pathsPoints) {
    List<PrepareResultToSending> prepareResults = [];

    pathsPoints.forEach((String taskId, FieldPath pathsValid) {
      prepareResults.add(PrepareResultToSending(
          id: taskId,
          result: ResultToSending(pathsValid.steps)
      ));
    });

    return prepareResults;
  }
}