// Flutter imports:
import 'package:flutter/material.dart';

class ColorBtn extends StatelessWidget {
  const ColorBtn({Key? key, required this.onPressed, this.color = Colors.black, this.child}) : super(key: key);
  final VoidCallback onPressed;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: color,
        shape: const CircleBorder(
          side: BorderSide(
            width: 4.0,
            color: Colors.black,
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
