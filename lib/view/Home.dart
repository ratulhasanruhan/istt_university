import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:istt_university/util/colors.dart';
import 'package:istt_university/widgets/class_card.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../controller/HomeController.dart';
import '../util/constants.dart';
import 'UpdateUser.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());

  var box = Hive.box('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return RefreshIndicator(
          onRefresh: () async {
            homeController.getData();
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: SvgPicture.asset(
                                'assets/academic.svg',
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  box.get('department'),
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "BATCH: ${box.get('batch')}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "SECTION: ${box.get('section')}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: UpdateUser(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/edit.svg',
                                height: 16,
                                width: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  homeController.selectedDate.value = selectedDate;
                },
                activeColor: primaryColor,
              ),
              SizedBox(
                height: 16,
              ),
              DateFormat('EEE').format(homeController.selectedDate.value) == 'Fri'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/holiday.json',
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "IT'S FRIDAY 🎉",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Classes",
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Builder(builder: (context) {
                          var newData = homeController.data.where((element) {
                            return element['date'].toDate().year ==
                                    homeController.selectedDate.value.year &&
                                element['date'].toDate().month ==
                                    homeController.selectedDate.value.month &&
                                element['date'].toDate().day ==
                                    homeController.selectedDate.value.day;
                          }).toList();

                          print(newData);

                          if(newData.isEmpty){
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/relax.json',
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    "NO CLASSES TODAY",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else{
                            return ListView.builder(
                              itemCount: newData.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ClassCard(
                                    courseName: newData[index]['name'],
                                    teacher: newData[index]['teacher'],
                                    room: newData[index]['room'],
                                    note: newData[index]['note'],
                                    startTime: newData[index]['start'].toDate(),
                                    endTime: newData[index]['end'].toDate(),
                                  ),
                                );
                              },
                            );
                          }
                        })
                      ],
                    )
            ],
          ),
        );
      }),
    );
  }
}
