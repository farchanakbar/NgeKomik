import 'package:get/get.dart';

import '../controllers/detail_komik_controller.dart';

class DetailKomikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailKomikController>(
      () => DetailKomikController(),
    );
  }
}
