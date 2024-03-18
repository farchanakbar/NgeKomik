import 'package:get/get.dart';

import '../controllers/detail_chapter_controller.dart';

class DetailChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailChapterController>(
      () => DetailChapterController(),
    );
  }
}
