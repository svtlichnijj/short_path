import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/steps_dto.dart';

import '../models/field_path.dart';

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
    // Map<String, FieldPath>? pathsPoints = {};
    print('pathsPoints b');
    print(pathsPoints);
    print(pathsPoints != null);
    // print(pathsPoints.isNotEmpty);

    while(pathsPoints == null/* && pathsPoints.isNotEmpty*/) {
      pathsPoints = await LocalStorage.getPaths();
      print('pathsPoints In');
      print(pathsPoints);
      await Future<void>.delayed(const Duration(seconds: 2));
    }

    print('pathsPoints a');
    print(pathsPoints);
    // if (pathsPoints is Map<String, FieldPath>) {
      yield prepareResultsFromPathsPoints(pathsPoints);
    // }
  }

  static List<PrepareResultToSending> prepareResultsFromPathsPoints(Map<String, FieldPath> pathsPoints) {
    List<PrepareResultToSending> prepareResults = [];

    // var pathPoints = await LocalStorage.getPath('7d785c38-cd54-4a98-ab57-44e50ae646c1');
    // print('pathPoints');
    // print(pathPoints);

    pathsPoints.forEach((String taskId, FieldPath pathsValid) {
      // // String pathString = '';
      // // for (var point in pathsValid.steps.points) {
      // //   pathString += point.toPath() + '->';
      // // }
      // PrepareResultToSending prepareResult = PrepareResultToSending(
      //     id: taskId,
      //     result: ResultToSending(pathsValid.steps)
      // );
      // prepareResults.add(prepareResult);
      // OR
      prepareResults.add(PrepareResultToSending(
          id: taskId,
          result: ResultToSending(pathsValid.steps)
      ));
    });

    return prepareResults;
  }
}

class ResultToSending {
  StepsDto steps;

  // // OR Path only
  // final StepsDto _steps;
  // // OR Without Path
  // final StepsDto steps;
  // // OR Path only
  // final String _path;
  // // OR Without Path
  // final String path;

  ResultToSending(this.steps);

  // // OR Path only
  // ResultToSending(Path path)
  //     : _steps = path.steps,
  //       _path = path.toResultToSending();
  // // OR Without Path
  // ResultToSending({
  //   required this.steps,
  //   required this.path
  // });

  factory ResultToSending.fromJson(Map<String, dynamic> jsonIn) =>
      ResultToSending(StepsDto.fromJson({'points': jsonIn['steps']}));
  // ResultToSending(StepsDto.fromJson(jsonIn['steps'] /* as Map<String, dynamic>*/));
  // // OR Without Path
  // factory ResultToSending.fromJson(Map<String, dynamic> jsonIn) {
  //   // print('-jsonIn-');
  //   // print(jsonIn);
  //   // print('jsonIn.runtimeType');
  //   // print(jsonIn.runtimeType);
  //   // print("'jsonIn['steps']'");
  //   // print(jsonIn['steps']);
  //   // print("'jsonIn['steps'].runtimeType'");
  //   // print(jsonIn['steps'].runtimeType);
  //   // print('+jsonIn+');
  //
  //   // Worked
  //   return ResultToSending(
  //     steps: StepsDto.fromJson({ 'points': jsonIn['steps'] }),
  //     path: jsonIn['path'] as String,
  //   );
  // }

  Map<String, dynamic> toJson() => {
        'steps': steps.toCoordinate(),
        'path': steps.toResultToSending(),
      };
// // OR Path only
// // Worked
// Map<String, dynamic> toJson() => {
//       'steps': _steps.toCoordinate(),
//       'path': _path,
//     };
// // OR Without Path
// // Worked
// Map<String, dynamic> toJson() =>
//     <String, dynamic>{
//       'steps': steps.toCoordinate(),
//       'path': path,
//     };
}
