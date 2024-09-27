import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:istt_university/util/colors.dart';
import 'package:istt_university/util/constants.dart';
import 'package:istt_university/view/Home.dart';
import 'package:istt_university/view/Infos.dart';
import 'package:istt_university/view/Profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'controller/HomeController.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: app_name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.roboto().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          onSecondary: secondaryColor,
          onPrimary: primaryColor,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeController homeController = Get.put(HomeController());

  List<PersistentBottomNavBarItem> items() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/icon_home_active.svg",
          height: 19,
          width: 19,
        ),
        icon: SvgPicture.asset(
          "assets/icon_home_active.svg",
          height: 19,
          width: 19,
        ),
        activeColorPrimary: Color(0xFF42C8B8),
        inactiveColorPrimary: Color(0xFF4D4D4D),
        title: "HOME",
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/icon_course_active.svg",
          height: 19,
          width: 19,
        ),
        icon: SvgPicture.asset(
          "assets/icon_course_active.svg",
          height: 19,
          width: 19,
        ),
        activeColorPrimary: Color(0xFFE09040),
        inactiveColorPrimary: Color(0xFF4D4D4D),
        title: "INFO",
      ),
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          "assets/icon_account_active.svg",
          height: 19,
          width: 19,
        ),
        icon: SvgPicture.asset(
          "assets/icon_account_active.svg",
          height: 19,
          width: 19,
        ),
        activeColorPrimary: Color(0xFF965DB0),
        inactiveColorPrimary: Color(0xFF4D4D4D),
        title: "LOGIN",
      ),
    ];
  }

  List<Widget> _screens() {
    return [
      Home(),
      Infos(),
      Profile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: homeController.persistentTabController,
        screens: _screens(),
        items: items(),
        hideOnScrollSettings: HideOnScrollSettings(
          hideNavBarOnScroll: true,
        ),
        navBarHeight: 52,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(horizontal: 10),
        onItemSelected: homeController.changeTabIndex,
        confineToSafeArea: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          colorBehindNavBar: context.theme.scaffoldBackgroundColor,
        ),
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        animationSettings: NavBarAnimationSettings(
          navBarItemAnimation: ItemAnimationSettings(
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
            animateTabTransition: false,
          ),
        ),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
