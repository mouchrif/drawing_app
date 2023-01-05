// Dart imports:
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:drawing_app/app/core/constants/messages_strings.dart';
import 'package:drawing_app/app/core/error/errors.dart';
import 'package:drawing_app/app/core/loading/loading_state.dart';
import 'package:drawing_app/app/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

// Project imports:
import 'package:drawing_app/app/data/models/drawing_line.dart';

class DrawingController extends GetxController {
  final globalKey = GlobalKey();
  final selectedColor = Colors.black.obs;
  final strokeWidth = 5.0.obs;

  final lines = <DrawnLine>[].obs;
  final currentLine = DrawnLine(lineColor: Colors.black, lineStroke: 5.0, points: []).obs;
  final linesStream = StreamController<DrawnLine>();

  final state = Rx<LoadingState>(const LoadingState.empty());
  StreamSubscription? stateSub;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    linesStream.stream.listen((line) => _addLine(line));
    stateSub = AppSnackBar(loadingState: state, position: SnackPosition.BOTTOM).initListener();
  }

  @override
  void onClose() {
    linesStream.close();
    stateSub?.cancel();
    super.onClose();
  }

  void _addLine(DrawnLine line) => lines.add(line);

  void onPanDown(DragDownDetails details) {
    currentLine.value = DrawnLine(lineColor: Colors.transparent, lineStroke: 0.0, points: []);
  }

  void onPanUpdate(DragUpdateDetails details, BuildContext context) {
    RenderBox object = context.findRenderObject() as RenderBox;
    Offset localPosition = object.globalToLocal(details.globalPosition);
    currentLine.value.points = List<Offset>.from(currentLine.value.points)..add(localPosition);
    currentLine.value =
        DrawnLine(lineColor: selectedColor.value, lineStroke: strokeWidth.value, points: currentLine.value.points);
  }

  void onPanEnd(DragEndDetails details) {
    linesStream.add(currentLine.value);
  }

  void setColor(Color color) {
    selectedColor.value = color;
  }

  void setStrokeWidth(double width) {
    strokeWidth.value = width;
  }

  void clearCanvas() {
    lines.clear();
    lines.refresh();
  }

  Future<void> saveImage() async {
    state.value = const LoadingState.loading();
    if(lines.isEmpty) {
      state.value = const LoadingState.error(message: MessagesStrings.drawingEmpty, type: MessageType.danger);
    }else{
      final permissionStatus = await _getPermissionStorageStatus();
      if (permissionStatus) {
        await _saveImageOnPhoneGallery();
      } else {
        final isGaranted = await _requestPermissionExternalStorage();
        if (isGaranted) {
          await _saveImageOnPhoneGallery();
        } else {
          state.value = const LoadingState.error(message: MessagesStrings.accessDenied, type: MessageType.danger);
        }
      }
    }
  }

  Future<void> _saveImageOnPhoneGallery() async {
    try {
      final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage();
      final ByteData? bytesData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytesData == null) return;
      final imageBytes = bytesData.buffer.asUint8List();
      final saved = await ImageGallerySaver.saveImage(
        imageBytes,
        quality: 100,
        name: '${DateTime.now().toIso8601String()}.png',
        isReturnImagePathOfIOS: true,
      );
      state.value = const LoadingState.loaded(message: MessagesStrings.imageSavedSuccessfuly, type: MessageType.success);
      print("SAVED: $saved");
    } catch (error) {
      print(error);
      state.value = const LoadingState.error(message: MessagesStrings.imageCannotBeSaved, type: MessageType.danger);
    }
  }

  Future<bool> _getPermissionStorageStatus() async {
    final status = await Permission.storage.status;
    return _handlePermission(status);
  }

  Future<bool> _requestPermissionExternalStorage() async {
    final status = await Permission.storage.request();
    return _handlePermission(status);
  }

  Future<bool> _handlePermission(PermissionStatus status) async {
    switch (status) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        return false;
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}
