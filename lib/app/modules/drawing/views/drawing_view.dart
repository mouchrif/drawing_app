// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:drawing_app/app/modules/drawing/controllers/drawing_controller.dart';
import 'package:drawing_app/app/modules/drawing/views/sketcher.dart';
import 'package:drawing_app/app/widgets/color_selection.dart';
import 'package:drawing_app/app/widgets/new_clear_button.dart';
import 'package:drawing_app/app/widgets/save_button.dart';
import 'package:drawing_app/app/widgets/stroke_selection.dart';

class DrawingView extends StatelessWidget {
  DrawingView({Key? key}) : super(key: key);
  final controller = Get.put(DrawingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      body: GestureDetector(
        onPanDown: (DragDownDetails details) => controller.onPanDown(details),
        onPanUpdate: (DragUpdateDetails details) => controller.onPanUpdate(details, context),
        onPanEnd: (DragEndDetails details) => controller.onPanEnd(details),
        child: Obx(
          () => Stack(
            children: [
              RepaintBoundary(
                child: CustomPaint(
                  painter: SketcherLines(
                    allLines: [controller.currentLine.value],
                  ),
                  size: Size.infinite,
                ),
              ),
              RepaintBoundary(
                key: controller.globalKey,
                child: CustomPaint(
                  painter: SketcherLines(
                    allLines: controller.lines.value,
                  ),
                  size: Size.infinite,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 40.0),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NewAndClearButton(
                        onPressed: controller.clearCanvas,
                        icon: Icons.edit,
                        controller: controller,
                      ),
                      const SizedBox(height: 10.0),
                      SaveButton(
                        controller: controller,
                        icon: Icons.save,
                        onPressed: () async => await controller.saveImage(),
                      ),
                      const SizedBox(height: 10.0),
                      ColorsSelection(controller: controller),
                      const SizedBox(height: 40.0),
                      Obx(
                        () => StrokesSelection(
                          controller: controller,
                          color: controller.selectedColor.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
