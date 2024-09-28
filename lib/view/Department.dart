import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istt_university/util/snack_bar.dart';
import 'package:istt_university/view/AddBatch.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../util/colors.dart';

class Department extends StatefulWidget {
  const Department({super.key});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {

  TextEditingController departmentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Department',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Get.dialog(
            AlertDialog(
              title: const Text('Add Department'),
              content: TextField(
                controller:  departmentController,
                decoration: const InputDecoration(
                  hintText: 'Enter Department Name',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance.collection('batch').doc(departmentController.text).set({
                      'list': [],
                    }).then((value) {
                      Get.back();
                      showSnack(context: context, type: ContentType.success, title: "SUCCESSFUL", message: "Department Added Successfully");
                    });
                  },
                  child: const Text(
                      'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('batch').snapshots(),
          builder: (context,AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddBatch(title: snapshot.data.docs[index].id),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    title: Text(snapshot.data.docs[index].id),
                    leading:  Icon(
                      Icons.school,
                      color: primaryColor,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: primaryColor,
                    ),
                  ),
                );
              },
            );
          },
      ),
    );
  }
}
