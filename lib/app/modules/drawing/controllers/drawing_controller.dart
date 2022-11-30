import 'dart:async';

import 'package:drawing_app/app/data/models/drawing_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawingController extends GetxController {
  final selectedColor = Colors.black.obs;
  final selectedStrokeWith = 5.0.obs;

  DrawnLine line = DrawnLine(lineColor: Colors.black, lineStroke: 5.0, points: []);
  List<DrawnLine> lines = [];

  final currentPathStream = StreamController<DrawnLine>.broadcast();
  final allPreviousPathsStream = StreamController<List<DrawnLine>>.broadcast();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    currentPathStream.close();
    allPreviousPathsStream.close();
    super.onClose();
  }

  void onPanStart(DragStartDetails details, BuildContext context) {
    final point = _getPoint(details, context);
    line = DrawnLine(
      lineColor: selectedColor.value,
      lineStroke: selectedStrokeWith.value,
      points: [point],
    );
    currentPathStream.add(line);
  }

  void onPanUpdate(DragUpdateDetails details, BuildContext context) {
    final point = _getPoint(details, context);
    final path = List<Offset>.from(line.points)..add(point);
    line = DrawnLine(
      lineColor: selectedColor.value,
      lineStroke: selectedStrokeWith.value,
      points: path,
    );
    currentPathStream.add(line);
  }

  void onPanEnd(DragEndDetails details, BuildContext context) {
    lines = List<DrawnLine>.from(lines)..add(line);
    allPreviousPathsStream.add(lines);
  }

  Offset _getPoint(dynamic details, BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.globalToLocal(details.globalPosition);
  }
}
