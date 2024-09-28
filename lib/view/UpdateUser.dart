import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:istt_university/main.dart';
import 'package:istt_university/util/snack_bar.dart';
import 'package:lottie/lottie.dart';

import '../util/colors.dart';
import '../util/constants.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  String department = '';
  String batch = '';
  String section = '';

  var box = Hive.box('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Lottie.asset(
                'assets/academic.json',
                height: 230,
                width: 230,
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('batch').snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    return snapshot.hasData? DropdownButtonFormField(
                      items: snapshot.data.docs.map<DropdownMenuItem<String>>((DocumentSnapshot document) {
                        return DropdownMenuItem(
                          value: document.id,
                          child: Text(document.id),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          department = value.toString();
                        });
                      },
                      hint: const Text('Select Department'),
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(12),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ): const CircularProgressIndicator();
                  }
              ),
              const SizedBox(
                height: 12,
              ),
              department != ''
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('batch').doc(department).snapshots(),
                        builder: (context,AsyncSnapshot snapshot) {
                          return snapshot.hasData?
                          DropdownButtonFormField(
                            items: snapshot.data['list'].map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                batch = value.toString();
                              });
                            },
                            hint: const Text('Select Batch'),
                            borderRadius: BorderRadius.circular(12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                            ),
                          )
                              : const CircularProgressIndicator();
                        }
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: DropdownButtonFormField(
                      items: sections.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          section = value.toString();
                        });
                      },
                      hint: const Text('Select Section'),
                      borderRadius: BorderRadius.circular(12),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ],
              ) : SizedBox.shrink(),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  if (department == '' || batch == '' || section == '') {
                    showSnack(context: context, type: ContentType.warning, title: "HEY", message: "Please fill all the fields");
                  } else {
                    box.put('department', department);
                    box.put('batch', batch);
                    box.put('section', section).then((value) {
                      Get.offAll(() => MyHomePage());
                      showSnack(context: Get.context!, type: ContentType.success, title: "UPDATED", message: "User details updated successfully");
                    });

                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
