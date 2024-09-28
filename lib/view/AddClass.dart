import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../util/colors.dart';
import '../util/constants.dart';
import '../util/snack_bar.dart';

class AddClass extends StatefulWidget {
  const AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final formKey = GlobalKey<FormState>();

  String department = '';
  String batch = '';
  String section = '';

  TextEditingController classNameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController startTimeController = TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  TextEditingController endTimeController = TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1))));

  DateTime selectedDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(hours: 1));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Class',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ): const CircularProgressIndicator();
                }
              ),
              const SizedBox(
                height: 12,
              ),
              department != ''
              ? Row(
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          )
                              : const CircularProgressIndicator();
                        }
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ) : SizedBox.shrink(),

              const SizedBox(
                height: 20,
              ),

              TextField(
                controller: classNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter Class Name',
                  label: Text('Class Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: roomController,
                decoration: const InputDecoration(
                  hintText: 'Enter Room Number',
                  label: Text('Room Number'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: teacherController,
                decoration: const InputDecoration(
                  hintText: 'Enter Teacher Name',
                  label: Text('Teacher Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  hintText: 'Enter Note',
                  label: Text('Note (Optional)'),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: 'Date',
                  label: Text('Class Date'),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2026),
                  ).then((value) {
                    if(value != null){
                      setState(() {
                        selectedDate = value;
                        dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
                      });
                    }
                  });

                },
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      controller: startTimeController,
                      decoration: const InputDecoration(
                        hintText: 'Start Time',
                        label: Text('Start Time'),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if(value != null){
                            setState(() {
                              startTimeController.text = DateFormat('hh:mm a').format(DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute));
                              startTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute);
                            });
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      controller: endTimeController,
                      decoration: const InputDecoration(
                        hintText: 'End Time',
                        label: Text('End Time'),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          if(value != null){
                            setState(() {
                              endTimeController.text = DateFormat('hh:mm a').format(DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute));
                              endTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, value.hour, value.minute);
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () async {
                  if(formKey.currentState!.validate()){
                    await FirebaseFirestore.instance.collection(department).doc(batch).collection(section).add({
                      'name': classNameController.text,
                      'room': roomController.text,
                      'teacher': teacherController.text,
                      'note': noteController.text ?? '',
                      'start': Timestamp.fromDate(startTime),
                      'end': Timestamp.fromDate(endTime),
                      'date': Timestamp.fromDate(selectedDate),
                    }).then((value) {
                      Navigator.pop(context);
                      showSnack(context: context, type: ContentType.success, title: "SUCCESSFUL", message: "Class Added Successfully");
                    });
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
                child: const Text(
                  'Add Class',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
