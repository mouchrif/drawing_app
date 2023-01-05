// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:drawing_app/app/core/error/errors.dart';
import 'package:drawing_app/app/core/loading/loading_state.dart';

class AppSnackBar {
  //final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final Rx<LoadingState?>? loadingState;
  final SnackPosition? position;
  AppSnackBar({this.scaffoldMessengerKey, this.loadingState, this.position});
  MessageType? messageType;
  String? message;

  StreamSubscription initListener() {
    StreamSubscription loadingSub = loadingState!.listen((value) {
      // ERROR
      if (value is ERROR) {
        message = value.message;
        messageType = value.type;
      } else if (value is LOADED) {
        message = value.message;
        messageType = value.type;
      } else {
        return;
      }

      /// Get color
      final color = _getColorByMessageType(messageType);

      /// hide snackbar if already exist
      if (Get.isSnackbarOpen) Get.back();

      Get.rawSnackbar(
        messageText: Text(
          message!,
          style: Get.theme.textTheme.bodyText1!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'Product Sans',
          ),
          textAlign: TextAlign.center,
        ),
        snackStyle: SnackStyle.FLOATING,
        backgroundColor: color,
        animationDuration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        borderRadius: 12,
        barBlur: 8,
        snackPosition: position ?? SnackPosition.BOTTOM,
      );

      /*scaffoldMessengerKey?.currentState
          ?..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                message!,
                style: context.theme.textTheme.bodyText1!.copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              backgroundColor: color,
              //behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              //margin: EdgeInsets.all(16),
            ),
          );*/
    });
    return loadingSub;
  }

  Color _getColorByMessageType(MessageType? messageType) {
    const double snackBarOpacity = 0.5;
    switch (messageType) {
      case MessageType.info:
        return MessageTypeColors.info.withOpacity(snackBarOpacity);
      case MessageType.danger:
        return MessageTypeColors.danger.withOpacity(snackBarOpacity);
      case MessageType.success:
        return MessageTypeColors.success.withOpacity(snackBarOpacity);
      case MessageType.warning:
        return MessageTypeColors.warning.withOpacity(snackBarOpacity);
      default:
        return MessageTypeColors.info.withOpacity(snackBarOpacity);
    }
  }
}
