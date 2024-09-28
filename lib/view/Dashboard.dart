import 'package:flutter/material.dart';
import 'package:istt_university/util/colors.dart';
import 'package:istt_university/view/AddBatch.dart';
import 'package:istt_university/view/Department.dart';
import 'package:istt_university/view/InfoUrl.dart';
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
                Icons.person_4_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Material(
              color: Color(0xFF55AD9B),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {

                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'ADD CLASS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Material(
                    color: Color(0xFF95D2B3),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: Department(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 130,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.class_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'DEPARTMENT',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),  
                const SizedBox(width: 20),
                Expanded(
                  child: Material(
                    color: Color(0xFF95D2B3),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: InfoUrl(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 130,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'INFO URL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
