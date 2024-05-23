import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeController extends GetxController{
  PersistentTabController persistentTabController = PersistentTabController(initialIndex: 0);

  void changeTabIndex(int index) async {
    Get.focusScope?.unfocus();
    persistentTabController.index = index;
     update();
  }

}