// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:drawing_app/app/modules/drawing/controllers/drawing_controller.dart';
import 'package:drawing_app/app/widgets/color_btn.dart';

class ColorsSelection extends StatelessWidget {
  const ColorsSelection({Key? key, required this.controller}) : super(key: key);
  final DrawingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ColorBtn(
          onPressed: () => controller.setColor(Colors.red),
          color: Colors.red,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.green),
          color: Colors.green,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.orangeAccent),
          color: Colors.orangeAccent,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.blueAccent),
          color: Colors.blueAccent,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.yellowAccent),
          color: Colors.yellowAccent,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.deepPurple),
          color: Colors.deepPurple,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.pinkAccent),
          color: Colors.pinkAccent,
        ),
        const SizedBox(
          height: 10,
        ),
        ColorBtn(
          onPressed: () => controller.setColor(Colors.black),
          color: Colors.black,
        ),
      ],
    );
  }
}
