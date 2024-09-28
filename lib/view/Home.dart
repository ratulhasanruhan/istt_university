import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:istt_university/util/colors.dart';
import 'package:istt_university/widgets/class_card.dart';
import '../controller/HomeController.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final homeController = Get.put(HomeController());

  var box = Hive.box('user');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 30),
        physics: const BouncingScrollPhysics(),
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
                              "CSE",
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
                              "BATCH: ",
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
                              "SECTION: ",
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
                        onTap: (){},
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

          ClassCard(
              courseName: "Software Engineering",
              room: "101",
              teacher: "Mr. XYZ",
              startTime: DateTime.now(),
              endTime: DateTime.now().add(Duration(hours: 1)),
          )

        ],
      ),
    );
  }
}
