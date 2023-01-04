// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:drawing_app/app/modules/drawing/views/drawing_view.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DRAWING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: _Paths.DRAWING,
      page: () => DrawingView(),
    ),
  ];
}
