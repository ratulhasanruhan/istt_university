import 'package:flutter/material.dart';
import 'package:istt_university/util/colors.dart';
import 'package:istt_university/view/ProfileView.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Dashboard',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: Profileview(),
                withNavBar: true, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            icon: const Icon(
                Icons.person,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}
