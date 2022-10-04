import 'dart:convert';

import 'package:short_path/data/api/path_finding_api.dart';
import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/point_dto.dart';
import 'package:short_path/domain/dto/prepare_result_to_sending.dart';
import 'package:short_path/domain/models/field.dart';
import 'package:short_path/domain/models/field_path.dart';
import 'package:short_path/domain/models/task.dart';


class ProcessFindPath {
  late List<Task> _tasks = [];
  late final Map<String, FieldPath> _pathsPoints = {};

  int percentageCalculation = 0;

  FieldPath pathsPoints(taskId) {
    return _pathsPoints[taskId] ?? FieldPath(Field([]));
  }

  Stream<ProcessFindPath> start(String? url) async* {
    await fillTasksFromApi(url);
    int percentPerTask = 100 ~/ _tasks.length;
    percentageCalculation = 0;

    for (int i = 0; i < _tasks.length; i++) {
      _pathsPoints[_tasks[i].id] = await calculateTask(_tasks[i]);
      percentageCalculation += percentPerTask;
      yield this;
      await Future<void>.delayed(const Duration(seconds: 2));
    }

    LocalStorage.setPaths(_pathsPoints);
    yield this;
  }

  Future<Task> fillTasksFromApi(String? url) async {
    _tasks = [];
    List<dynamic> tasksData = await PathFinderApi.getTasksData(url);

    for (var taskData in tasksData) {
      _tasks.add(Task.fromJson(taskData));
    }

    return _tasks.first;
  }

  Future<FieldPath> calculateTask(Task task) async {
    List<FieldPath> pathsPotential = [FieldPath(task.field)];
    pathsPotential.first.addPoint(task.start);

    if (task.getMinSteps() == 1) {
      pathsPotential.first.addPoint(task.end);

      return pathsPotential.first;
    }

    List<FieldPath> pathsValid = [];

    while (pathsValid.isEmpty) {
      for (int ps = 0; ps < pathsPotential.length; ps++) {
        FieldPath pathPotential = FieldPath.fromJson(pathsPotential.first.toJson());
        PointDto pathPotentialLastStep = pathPotential.points.last;
        int plusCurrStepX = (task.end.x - pathPotentialLastStep.x).sign;
        int plusCurrStepY = (task.end.y - pathPotentialLastStep.y).sign;

        int plusBeforeYAfterX = (plusCurrStepX + plusCurrStepY).sign;
        int plusBeforeStepX = (plusCurrStepX - plusCurrStepY).sign;
        int plusAfterStepY = (plusCurrStepY - plusCurrStepX).sign;
        Set<List<int>> nextCoordinates = {};
        nextCoordinates.addAll([
          [pathPotentialLastStep.x + plusCurrStepX, pathPotentialLastStep.y + plusCurrStepY],
          [pathPotentialLastStep.x + plusBeforeStepX, pathPotentialLastStep.y + plusBeforeYAfterX],
          [pathPotentialLastStep.x + plusBeforeYAfterX, pathPotentialLastStep.y + plusAfterStepY],
        ]);

        for (List<int> nextCoordinate in nextCoordinates) {
          FieldPath currentPath = FieldPath.fromJson(pathPotential.toJson());

          if (currentPath.addPointByXY(nextCoordinate[0], nextCoordinate[1])) {
            if (currentPath.points.last.isEqual(task.end)) {
              pathsValid.add(currentPath);
            }

            pathsPotential.add(currentPath);
          }
        }

        pathsPotential.removeAt(0);
      }
    }

    if (pathsValid.isEmpty) {
      throw Exception('Can\'t fount valid path');
    }

    return pathsValid.reduce((pathSmaller, path) {
      return pathSmaller.points.length < path.points.length ? pathSmaller : path;
    });
  }

  Future<List<PrepareResultToSending>?> sendCalculatedPaths() async {
    List<PrepareResultToSending> prepareResultsToSending = PrepareResultToSending.prepareResultsFromPathsPoints(_pathsPoints);
    List<dynamic> tasksData = await PathFinderApi.setResults(jsonEncode(prepareResultsToSending));

    if (tasksData.isNotEmpty && tasksData.first.containsKey('correct')) {
      if (tasksData.map((e) => e['correct']).reduce((value, element) => value && element)) {
        return prepareResultsToSending;
      }
    }

    return null;
  }
}