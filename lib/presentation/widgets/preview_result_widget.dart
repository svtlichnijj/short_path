import 'package:flutter/material.dart';
import 'package:short_path/data/local/local_storage.dart';
import 'package:short_path/domain/dto/point_dto.dart';
import 'package:short_path/domain/enums/point_color.dart';
import 'package:short_path/domain/models/field_path.dart';
import 'package:short_path/presentation/widgets/text_container.dart';

class PreviewResultWidget extends StatefulWidget {
  final String taskId;

  const PreviewResultWidget({Key? key, required this.taskId}) : super(key: key);

  @override
  State<PreviewResultWidget> createState() => _PreviewResultWidgetState();
}

class _PreviewResultWidgetState extends State<PreviewResultWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _constructPreviewResultTable(),
      builder: (BuildContext context, AsyncSnapshot<List<TableRow>> snapshot) {
        if (snapshot.hasData) {
          return Table(
            children: snapshot.data ?? [],
            border: TableBorder.all(
              color: Colors.red,
              width: 3.0,
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextContainer.getTextError(context, 'Can\'t found preview result by task id: "${widget.taskId}"')
              ],
            ),
          );
        }
      },
    );
  }

  Future<List<TableRow>> _constructPreviewResultTable() async {
    List<TableRow> fieldRows = [];
    FieldPath? path = await LocalStorage.getPath(widget.taskId);

    if (path == null) {
      return fieldRows;
    }

    List<List<PointDto>> pathFieldPoints = path.field.rowsColumns;

    for (int r = 0; r <= pathFieldPoints.length - 1; r++) {
      List<TableCell> tableCells = [];
      List<PointDto> row = pathFieldPoints[r];
      int rowLength = row.length;
      double squareDimension = MediaQuery.of(context).size.width / rowLength;

      for (int c = 0; c <= rowLength - 1; c++) {
        tableCells.add(TableCell(
            child: SizedBox.square(
              child: Container(
                color: PointColor.get(path.getPointColorType(row[c])),
                child: Center(
                  child: Text(
                    row[c].toPath(),
                    style: const TextStyle(backgroundColor: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              dimension: squareDimension,
            )
        ));
      }
      fieldRows.add(TableRow(children: tableCells));
    }

    return fieldRows;
  }
}
