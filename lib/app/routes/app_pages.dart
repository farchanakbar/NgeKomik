import 'package:get/get.dart';

import '../modules/detail_chapter/bindings/detail_chapter_binding.dart';
import '../modules/detail_chapter/views/detail_chapter_view.dart';
import '../modules/detail_komik/bindings/detail_komik_binding.dart';
import '../modules/detail_komik/views/detail_komik_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KOMIK,
      page: () => const DetailKomikView(),
      binding: DetailKomikBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CHAPTER,
      page: () => const DetailChapterView(),
      binding: DetailChapterBinding(),
    ),
  ];
}
