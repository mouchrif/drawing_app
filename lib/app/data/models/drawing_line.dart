import 'package:flutter/material.dart';

class DrawnLine {
  final Color lineColor;
  final double lineStroke;
  final List<Offset> points;

  DrawnLine({
    required this.lineColor,
    required this.lineStroke,
    required this.points,
  });
}
