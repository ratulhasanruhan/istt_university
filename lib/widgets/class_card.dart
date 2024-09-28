import 'dart:math';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:istt_university/util/snack_bar.dart';

import '../util/colors.dart';

class ClassCard extends StatelessWidget {
  final String courseName;
  final String room;
  final String teacher;
  final String? note;
  final DateTime startTime;
  final DateTime endTime;

  const ClassCard({
    super.key,
    required this.courseName,
    required this.room,
    required this.teacher,
    this.note,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, top: 10, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    courseName,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      shadows: [
                        Shadow(
                            color: Colors.white,
                            offset: Offset(0, -4))
                      ],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 1.7,
                      fontWeight: FontWeight.w500,
                      color: Colors.transparent,
                    ),
                  ),
                ),

                Text(
                  "Room: #$room",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),

                Text(
                  "Teacher: $teacher",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                note == null || note == ""
                    ? Container()
                    : Text(
                  "Note: $note",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: Colors.white,
            thickness: 1.7,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Text(
                  '${DateFormat("hh:mm").format(startTime)} - ${DateFormat("hh:mm").format(endTime)}',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () async {
                      final alarmSettings = AlarmSettings(
                        id: Random().nextInt(10) +1,
                        dateTime: startTime.subtract(Duration(minutes: 10)),
                        assetAudioPath: 'assets/alarm.mp3',
                        loopAudio: false,
                        vibrate: true,
                        volume: 0.8,
                        notificationTitle: '$courseName class is about to start',
                        notificationBody: 'Room: #$room, Teacher: $teacher',
                      );
                      await Alarm.set(alarmSettings: alarmSettings).then((value) {
                        showSnack(
                            context: context,
                            type: ContentType.success,
                            title: 'Success',
                            message: 'Alarm set for $courseName class',
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/notification.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
