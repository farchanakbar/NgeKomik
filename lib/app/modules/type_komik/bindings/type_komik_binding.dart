import 'package:get/get.dart';

import '../controllers/type_komik_controller.dart';

class TypeKomikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TypeKomikController>(
      () => TypeKomikController(),
    );
  }
}
