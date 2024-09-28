import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeController extends GetxController{
  PersistentTabController persistentTabController = PersistentTabController(initialIndex: 0);

  var selectedDate = DateTime.now().obs;
  RxBool isLoggedIn = false.obs;

  var box = Hive.box('user');

  var data = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLogin();
    getData();
  }

  getData() async{
    if(box.isNotEmpty){
      await FirebaseFirestore.instance.collection(box.get('department')).doc(box.get('batch')).collection(box.get('section')).get().then((value) {
        data.assignAll(value.docs);
      });
    }
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