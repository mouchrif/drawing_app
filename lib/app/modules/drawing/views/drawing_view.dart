import 'package:flutter/material.dart';
import 'package:drawing_app/app/modules/drawing/views/drawing_current_line.dart';
import 'package:drawing_app/app/modules/drawing/views/drawing_previous_lines.dart';

import 'package:get/get.dart';

import '../controllers/drawing_controller.dart';

class DrawingView extends StatelessWidget {
  DrawingView({Key? key}) : super(key: key);
  final controller = Get.put(DrawingController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow.shade100,
        body: SizedBox.expand(
          child: GestureDetector(
            onPanStart: (details) => controller.onPanStart(details, context),
            onPanUpdate: (details) => controller.onPanUpdate(details, context),
            onPanEnd: (details) => controller.onPanEnd(details, context),
            child: RepaintBoundary(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DrawingCurrentLine(controller: controller),
                  DrawingPreviousLines(controller: controller),
                  // StreamBuilder(
                  //   stream: controller.currentPathStream.stream,
                  //   builder: ((context, snapshot) {
                  //     return CustomPaint(
                  //       painter: Sketcher(lines: [snapshot.data]),
                  //     );
                  //   }),
                  // ),
                  // StreamBuilder(
                  //   stream: controller.allPreviousPathsStream.stream,
                  //   builder: ((context, snapshot) {
                  //     return CustomPaint(
                  //       painter: Sketcher(lines: controller.lines),
                  //     );
                  //   }),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
