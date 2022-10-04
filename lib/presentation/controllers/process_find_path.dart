import 'dart:convert';

import 'package:short_path/data/api/path_finding_api.dart';
import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/point_dto.dart';
// import 'package:short_path/domain/dto/result_to_sending.dart';
import 'package:short_path/domain/dto/results_to_sending.dart';
import 'package:short_path/domain/models/field.dart';
import 'package:short_path/domain/models/field_path.dart';
import 'package:short_path/domain/models/task.dart';


class ProcessFindPath {
  late List<Task> _tasks = [];
  late final Map<String, FieldPath> _pathsPoints = {};
  // late Map<String, List<Point>> pathsPoints;
  // bool _isCalculationFinished = false;

  int percentageCalculation = 0;
  // ValueNotifier<bool> isCalculationFinished = ValueNotifier(false);

  // get isCalculationFinished {
  //   print('-isCalculationFinished-');
  //   return _isCalculationFinished;
  // }

  FieldPath pathsPoints(taskId) {
    return _pathsPoints[taskId] ?? FieldPath(Field([]));
  }

  Stream<ProcessFindPath> start(String? url) async* {
  // Future<ProcessFindPath> start(String? url) async {
  //   _isCalculationFinished = false;

    if (url != null) {
      await fillTasksFromApi(url);
      int percentPerTask = 100 ~/ _tasks.length;
      percentageCalculation = 0;

      for (int i = 0; i < _tasks.length; i++) {
        // await Future<void>.delayed(const Duration(seconds: 5)); // ToDo remove
        _pathsPoints[_tasks[i].id] = await calculateTask(_tasks[i]);
        percentageCalculation += percentPerTask;
        // throw Exception('Failed to load album');
        print('---percentageCalculation---');
        print(percentageCalculation);
        // await Future<void>.delayed(const Duration(seconds: 6));
        yield this;
        await Future<void>.delayed(const Duration(seconds: 2));
      }

      LocalStorage.setPaths(_pathsPoints);
      yield this;
      // LocalStorage.setPaths(_pathsPoints);
      // isCalculationFinished.value = true;
      // return this;
      // return percentageCalculation;
    // } else {
    //   List<PrepareResultToSending>? prepareResultsToSending = await sendCalculatedPaths();
    //
    //   if (prepareResultsToSending != null) {
    //   }
    //
    //   percentageCalculation += percentageCalculation;
    }

    // _isCalculationFinished = true;
  }

  Future<Task> fillTasksFromApi(String? url) async {
    _tasks = [];
    List<dynamic> tasksData = await PathFinderApi.getTasksData(url);
    // print('addTasksFromApi');

    for (var taskData in tasksData) {
      // print(taskData);
      _tasks.add(Task.fromJson(taskData));
    }

    return _tasks.first;
  }

  Future<FieldPath> calculateTask(Task task) async {
  // Future<List<Point>> calculateTask(Task task) async {
    List<FieldPath> pathsPotential = [FieldPath(task.field)];
    pathsPotential.first.addPoint(task.start);
    // List<List<Point>> pathsPotential = [[task.start]];

    if (task.getMinSteps() == 1) {
      pathsPotential.first.addPoint(task.end);
      // pathsPotential.first.add(task.end);

      return pathsPotential.first;
    }

    // Field currentField = task.field;
    List<FieldPath> pathsValid = [];
    // List<List<Point>> pathsValid = [];

    while (pathsValid.isEmpty) {
      for (int ps = 0; ps < pathsPotential.length; ps++) {
        // // print('##    pathsPotential.first.field.rowsColumns');
        // // print(pathsPotential.first.field.rowsColumns);
        // // print('##    jsonEncode(pathsPotential.first.field.rowsColumns)');
        // // print(jsonEncode(pathsPotential.first.field.rowsColumns));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first.field.rowsColumns))');
        // // print(jsonDecode(jsonEncode(pathsPotential.first.field.rowsColumns)));
        // // print('##    pathsPotential.first.field');
        // // print(pathsPotential.first.field);
        // // print('##    jsonEncode(pathsPotential.first.field)');
        // // print(jsonEncode(pathsPotential.first.field));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first.field))');
        // // print(jsonDecode(jsonEncode(pathsPotential.first.field)));
        //
        // // print('##    pathsPotential.first.steps.points.first');
        // // print(pathsPotential.first.steps.points.first);
        // // print('##    jsonEncode(pathsPotential.first.steps.points.first)');
        // // print(jsonEncode(pathsPotential.first.steps.points.first));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first.steps.points.first))');
        // // print(jsonDecode(jsonEncode(pathsPotential.first.steps.points.first)));
        // // print('##    pathsPotential.first.steps.points.toList()');
        // // print(pathsPotential.first.steps.points.toList());
        // // print('##    jsonEncode(pathsPotential.first.steps.points.toList())');
        // // print(jsonEncode(pathsPotential.first.steps.points.toList()));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first.steps.points.toList()))');
        // // print(jsonDecode(jsonEncode(pathsPotential.first.steps.points.toList())));
        // // print('##    jsonEncode(pathsPotential.first.steps.points)');
        // // print(jsonEncode(pathsPotential.first.steps.points));
        // // print('##    pathsPotential.first.steps');
        // // print(pathsPotential.first.steps);
        // // print('##    jsonEncode(pathsPotential.first.steps)');
        // // print(jsonEncode(pathsPotential.first.steps));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first.steps))');
        // // print(jsonDecode(jsonEncode(pathsPotential.first.steps)));
        // print('##    pathsPotential.first');
        // print(pathsPotential.first);
        // print('##    pathsPotential.first.runtimeType');
        // print(pathsPotential.first.runtimeType);
        // print('##    pathsPotential.first.toJson()');
        // print(pathsPotential.first.toJson());
        // print('##    pathsPotential.first.toJson().runtimeType');
        // print(pathsPotential.first.toJson().runtimeType);
        // print('##    jsonEncode(pathsPotential.first)');
        // print(jsonEncode(pathsPotential.first));
        // // print('##    jsonEncode(pathsPotential.first).runtimeType');
        // print(jsonEncode(pathsPotential.first).runtimeType);
        // print('##    jsonDecode(jsonEncode(pathsPotential.first))');
        // print(jsonDecode(jsonEncode(pathsPotential.first)));
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first)).runtimeType');
        // print(jsonDecode(jsonEncode(pathsPotential.first)).runtimeType);
        // // print('##    jsonDecode(jsonEncode(pathsPotential.first)) as Path');
        // // print(jsonDecode(jsonEncode(pathsPotential.first)) as Path);
        // // print('Path.fromJson(pathsPotential.first.toJson())))');
        // // print(Path.fromJson(jsonEncode(pathsPotential.first)));
        // print('Path.fromJson(jsonDecode(jsonEncode(pathsPotential.first)))');
        // print(Path.fromJson(jsonDecode(jsonEncode(pathsPotential.first))));
        // Path pathPotential = Path.fromJson(jsonDecode(jsonEncode(pathsPotential.first)));
        // OR
        FieldPath pathPotential = FieldPath.fromJson(pathsPotential.first.toJson());
        // // OR
        // // Path pathPotential = Path.fromJson(pathsPotential.first.toJson());
        // print('pathPotential');
        // print(pathPotential);
        // print('jsonEncode(pathPotential)');
        // print(jsonEncode(pathPotential));
        PointDto pathPotentialLastStep = pathPotential.points.last;
        // PointDto pathPotentialLastStep = pathPotential.steps.last;
        // PointDto pathPotentialLastStep = pathPotential.steps.points.last;
        // Point pathPotentialLastStep = pathsPotential.first.last;
        int plusCurrStepX = (task.end.x - pathPotentialLastStep.x).sign;
        int plusCurrStepY = (task.end.y - pathPotentialLastStep.y).sign;

        // List<PointDto> nextPoints = [];
        int plusBeforeYAfterX = (plusCurrStepX + plusCurrStepY).sign;
        int plusBeforeStepX = (plusCurrStepX - plusCurrStepY).sign;
        int plusAfterStepY = (plusCurrStepY - plusCurrStepX).sign;
        Set<List<int>> nextCoordinates = {};
        nextCoordinates.addAll([
          [pathPotentialLastStep.x + plusCurrStepX, pathPotentialLastStep.y + plusCurrStepY],
          [pathPotentialLastStep.x + plusBeforeStepX, pathPotentialLastStep.y + plusBeforeYAfterX],
          [pathPotentialLastStep.x + plusBeforeYAfterX, pathPotentialLastStep.y + plusAfterStepY],
        ]);
        // print('nextCoordinates');
        // print(nextCoordinates);
        // print('nextCoordinates.length');
        // print(nextCoordinates.length);

        for (List<int> nextCoordinate in nextCoordinates) {
          // print('-nextCoordinate-');
          // print(nextCoordinate);
          // print(nextCoordinate.runtimeType);
          FieldPath currentPath = FieldPath.fromJson(pathPotential.toJson());
          // Path currentPath = Path.fromJson(jsonDecode(jsonEncode(pathPotential)));
          // print('currentPath');
          // print(currentPath);
          // print(currentPath.runtimeType);

          if (currentPath.addPointByXY(nextCoordinate[0], nextCoordinate[1])) {
            if (currentPath.points.last.isEqual(task.end)) {
            // if (currentPath.steps.last.isEqual(task.end)) {
            // if (currentPath.steps.points.last.isEqual(task.end)) {
              pathsValid.add(currentPath);
            }

            // print('pathsPotentialB');
            // print(pathsPotential);
            pathsPotential.add(currentPath);
            // print('pathsPotentialA');
            // print(pathsPotential);
          }
        }

        // print('pathsPotentialBR');
        // print(pathsPotential);
        pathsPotential.removeAt(0);
        // print('pathsPotentialAR');
        // print(pathsPotential);

        /*
        int maxX = currentField.rowsColumns.first.length - 1;
        int maxY = currentField.rowsColumns.length - 1;
        int nextStepX = pathPotentialLastStep.x + plusCurrStepX;
        int nextStepY = pathPotentialLastStep.y + plusCurrStepY;
        int beforeStepX = pathPotentialLastStep.x + plusBeforeStepX;
        int beforeStepY = pathPotentialLastStep.y + plusBeforeYAfterX;
        int afterStepX = pathPotentialLastStep.x + plusBeforeYAfterX;
        int afterStepY = pathPotentialLastStep.y + plusAfterStepY;

        if (nextStepY <= maxY && nextStepX <= maxX) {
          nextPoints.add(currentField.rowsColumns[nextStepY][nextStepX]);
        }

        if (beforeStepY <= maxY && beforeStepX <= maxX) {
          nextPoints.add(currentField.rowsColumns[beforeStepY][beforeStepX]);
        }

        if (afterStepY <= maxY && afterStepX <= maxX) {
          nextPoints.add(currentField.rowsColumns[afterStepY][afterStepX]);
        }

        Set<Point> seen = <Point>{};
        nextPoints = nextPoints.where((p) => p.state == PointStates.passing ? seen.add(p) : false).toList();
        Path currentPath = json.decode(json.encode(pathsPotential.first));
        // List<Point> currentPathFrom = List<Point>.from(pathsPotential.first);

        for (int np = 0; np < nextPoints.length; np++) {
          // Point nextPoint = nextPoints[np];
          // List<Point> currentPath = List<Point>.from(currentPathFrom);
          currentPath.addPoint(nextPoints[np]);
          // currentPath.add(nextPoints[np]);
          // currentPath.add(nextPoint);

          if (currentPath.path.last.isEqual(task.end)) {
          // if (currentPath.last.isEqual(task.end)) {
          // if (nextPoint.isEqual(task.end)) {
            pathsValid.add(currentPath);
          }

          pathsPotential.add(currentPath);
        }

        pathsPotential.removeAt(0);
         */
      }
    }

    if (pathsValid.isEmpty) {
      throw Exception('Can\'t fount valid path');
    }

    return pathsValid.reduce((pathSmaller, path) => pathSmaller.points.length < path.points.length ? pathSmaller : path);
    // return pathsValid.reduce((pathSmaller, path) => pathSmaller.steps.length < path.steps.length ? pathSmaller : path);
    // return pathsValid.reduce((pathSmaller, path) => pathSmaller.steps.points.length < path.steps.points.length ? pathSmaller : path);
    // return pathsValid.reduce((pathSmaller, path) => pathSmaller.length < path.length ? pathSmaller : path);
  }

  Future<List<PrepareResultToSending>?> sendCalculatedPaths() async {   // ToDo as Stream this.start()
    // _isCalculationFinished = false;
    // isCalculationFinished.value = false;
    List<PrepareResultToSending> prepareResultsToSending = PrepareResultToSending.prepareResultsFromPathsPoints(_pathsPoints);
    // List<PrepareResultToSending> prepareResultsToSending = getPrepareResultsToSending();
    List<dynamic> tasksData = await PathFinderApi.setResults(jsonEncode(prepareResultsToSending));

    if (tasksData.isNotEmpty) {
      // _isCalculationFinished = true;
      // isCalculationFinished.value = true;

      if (tasksData.first.containsKey('correct') && tasksData.map((e) => e['correct']).reduce((value, element) => value && element)) {
        return prepareResultsToSending;
      }
    }

    return null;
  }

  List<PrepareResultToSending> getPrepareResultsToSending() {
    List<PrepareResultToSending> prepareResults = [];

    _pathsPoints.forEach((String taskId, FieldPath pathsValid) {
      // String pathString = '';
      // for (var point in pathsValid.steps.points) {
      //   pathString += point.toPath() + '->';
      // }
      PrepareResultToSending prepareResult = PrepareResultToSending(
          id: taskId,
          result: ResultToSending(pathsValid.steps)
          // result: ResultToSending(pathsValid)
          // result: ResultToSending(
          //   steps: pathsValid.steps,
          //   path: pathsValid.toResultToSending(),
          // //   path: pathString,
          // )
      );

      // print('prepareResult.toJson()');
      // print(prepareResult.toJson());
      // print('prepareResult.result.toJson()');
      // print(prepareResult.result.toJson());
      // print('PrepareResultToSending.fromJson(prepareResult.toJson())');
      // print(PrepareResultToSending.fromJson(prepareResult.toJson()));
      // print('PrepareResultToSending.fromJson(prepareResult.toJson()).result.toJson()');
      // print(PrepareResultToSending.fromJson(prepareResult.toJson()).result.toJson());
      prepareResults.add(prepareResult);
    });

    /*
    for (int i = 0; i < tasks.length; i++) {
      String taskId = tasks[i].id;
      if (pathsPoints[taskId] != null) {
        Set<PointDto>? pathsValid = pathsPoints[taskId]?.path;
        String pathString = '';
        pathsValid?.forEach((point) {
        // pathsPoints[taskId]?.forEach((point) {
          pathString += point.toPath() + '->';
        });
        PrepareResultToSending prepareResult = PrepareResultToSending(
            id: taskId,
            result: ResultToSending(
              steps: pathsPoints[taskId],
              path: pathString,
            )
        );

        prepareResults.add(prepareResult);
        // prepareResults.add({
        //   'id': taskId,
        //   'result': {
        //     'steps': pathsPoints[taskId],
        //     'pathString': pathString.substring(0, pathString.length - 2),
        //   },
        // });
      }
    }
     */
    // print('prepareResults.map((e) => e.toJson())');
    // print(prepareResults.map((e) => e.toJson()));
    // print('jsonEncode(prepareResults.map((e) => e.toJson()))');
    // print(jsonEncode(prepareResults.map((e) => e.toJson())));
    // print('jsonEncode(prepareResults.map((e) => e.toJson()).toString())');
    // print(jsonEncode(prepareResults.map((e) => e.toJson())).toString());
    // print('jsonEncode(prepareResults.map((e) => e.toJson()))');
    // print(jsonEncode(prepareResults.map((e) => e.toJson())));
    // print('prepareResults.map((e) => e.toJson()).toList()');
    // print(prepareResults.map((e) => e.toJson()).toList());
    // print('prepareResults.map((e) => e.toJson()).toList().toString()');
    // print(prepareResults.map((e) => e.toJson()).toList().toString());
    // print('jsonEncode(prepareResults)');
    // print(jsonEncode(prepareResults));

    // return prepareResults.map((e) => e.toJson()).toJson();
    // return prepareResults.map((e) => e.toJson()).toList().toString();
    // return prepareResults.map((e) => e.toJson()).toString();
    // return jsonEncode(prepareResults.map((e) => e.toJson()));
    return prepareResults;
    // return jsonEncode(prepareResults);
  }
}