import 'package:flutter/material.dart';

enum MessageType{
  info,
  success,
  danger,
  warning,
}

class MessageTypeColors {
  static const Color danger = Color(0xFFFF4B6D);

  static const Color success = Color(0xFF2ECC71);

  static const Color warning = Color(0xFFF7B500);

  static const Color info = Color(0xFF0082FF);
}