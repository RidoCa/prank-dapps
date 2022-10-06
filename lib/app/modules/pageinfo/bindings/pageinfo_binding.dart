import 'package:get/get.dart';

import '../controllers/pageinfo_controller.dart';

class PageinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PageinfoController>(
      () => PageinfoController(),
    );
  }
}
