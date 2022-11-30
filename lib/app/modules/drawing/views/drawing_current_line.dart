import 'package:drawing_app/app/modules/drawing/controllers/drawing_controller.dart';
import 'package:drawing_app/app/modules/drawing/views/sketcher.dart';
import 'package:flutter/material.dart';

class DrawingCurrentLine extends StatelessWidget {
  final DrawingController controller;
  const DrawingCurrentLine({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.currentPathStream.stream,
      builder: ((context, snapshot) {
        if (!snapshot.hasError) {
          return CustomPaint(
            painter: Sketcher(lines: [snapshot.data]),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}