// Dart imports:
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    linesStream.stream.listen((line) => _addLine(line));
  }

  @override
  void onClose() {
    linesStream.close();
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
    final permissionStatus = await _getPermissionStorageStatus();
    if (permissionStatus) {
      await _saveImageOnPhoneGallery();
    } else {
      final isGaranted = await _requestPermissionExternalStorage();
      if (isGaranted) {
        await _saveImageOnPhoneGallery();
      } else {
        print("ACCESS DENIED");
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
      print("SAVED: $saved");
    } catch (error) {
      print(error);
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
