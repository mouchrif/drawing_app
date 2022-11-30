import 'package:drawing_app/app/data/models/drawing_line.dart';
import 'package:flutter/material.dart';

class Sketcher extends CustomPainter {
  final List<DrawnLine?> lines;
  Sketcher({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    if (lines.isEmpty) return;
    for (var i = 0; i < lines.length; i++) {
      if (lines[i] == null) continue;
      for (var j = 0; j < lines[i]!.points.length - 1; j++) {
        if (lines[i]?.points[j] != null && lines[i]?.points[j + 1] != null) {
          paint.color = lines[i]!.lineColor;
          paint.strokeCap = StrokeCap.round;
          paint.strokeWidth = lines[i]!.lineStroke;
          canvas.drawLine(lines[i]!.points[j], lines[i]!.points[j + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
