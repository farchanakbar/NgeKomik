import 'package:get/get.dart';

import '../controllers/genre_item_controller.dart';

class GenreItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreItemController>(
      () => GenreItemController(),
    );
  }
}
