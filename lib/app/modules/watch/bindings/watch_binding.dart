import 'package:get/get.dart';
import 'package:footballnews_mobile/app/modules/watch/controllers/watch_controller.dart';

class WatchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WatchController());
  }
}
