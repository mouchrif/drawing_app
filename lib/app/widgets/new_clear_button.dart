// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:drawing_app/app/modules/drawing/controllers/drawing_controller.dart';
import 'package:drawing_app/app/widgets/color_btn.dart';

class NewAndClearButton extends StatelessWidget {
  const NewAndClearButton({Key? key, required this.onPressed, required this.icon, required this.controller})
      : super(key: key);
  final VoidCallback onPressed;
  final IconData icon;
  final DrawingController controller;

  @override
  Widget build(BuildContext context) {
    return ColorBtn(
      onPressed: onPressed,
      color: Colors.blue.shade400,
      child: Icon(
        icon,
        size: 18.0,
      ),
    );
  }
}
