// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:drawing_app/app/data/models/drawing_line.dart';

class SketcherLines extends CustomPainter {
  SketcherLines({required this.allLines});

  final List<DrawnLine> allLines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < allLines.length; i++) {
      for (int j = 0; j < allLines[i].points.length - 1; j++) {
        if (allLines[i].points[j] != null && allLines[i].points[j + 1] != null) {
          final paint = Paint()
            ..color = allLines[i].lineColor
            ..strokeCap = StrokeCap.round
            ..strokeWidth = allLines[i].lineStroke;
          canvas.drawLine(allLines[i].points[j], allLines[i].points[j + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(SketcherLines oldDelegate) => true;
}
