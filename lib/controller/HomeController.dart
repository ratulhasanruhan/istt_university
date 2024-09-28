import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeController extends GetxController{
  PersistentTabController persistentTabController = PersistentTabController(initialIndex: 0);

  var selectedDate = DateTime.now().obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLogin();
  }

  checkLogin() async {
    FirebaseAuth.instance.currentUser != null ? isLoggedIn = true.obs : isLoggedIn = false.obs;
    print(isLoggedIn);
  }


  void changeTabIndex(int index) async {
    Get.focusScope?.unfocus();
    persistentTabController.index = index;
     update();
  }

}