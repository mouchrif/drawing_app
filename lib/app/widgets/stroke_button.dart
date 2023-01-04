// Flutter imports:
import 'package:flutter/material.dart';

class StrokeButton extends StatelessWidget {
  const StrokeButton({Key? key, required this.onPressed, this.color = Colors.black, this.height}) : super(key: key);
  final Color color;
  final VoidCallback onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: color,
          shape: const CircleBorder(),
        ),
        onPressed: onPressed,
        child: null,
      ),
    );
  }
}
