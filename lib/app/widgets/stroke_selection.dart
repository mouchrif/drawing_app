// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:drawing_app/app/modules/drawing/controllers/drawing_controller.dart';
import 'package:drawing_app/app/widgets/stroke_button.dart';

class StrokesSelection extends StatelessWidget {
  const StrokesSelection({Key? key, required this.controller, this.color = Colors.black}) : super(key: key);
  final DrawingController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StrokeButton(
          onPressed: () => controller.setStrokeWidth(6.0),
          height: 20.0,
          color: color,
        ),
        const SizedBox(height: 10.0),
        StrokeButton(
          onPressed: () => controller.setStrokeWidth(10.0),
          height: 30.0,
          color: color,
        ),
        const SizedBox(height: 10.0),
        StrokeButton(
          onPressed: () => controller.setStrokeWidth(15.0),
          color: color,
        ),
      ],
    );
  }
}
