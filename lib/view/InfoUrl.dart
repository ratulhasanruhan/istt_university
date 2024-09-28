import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/colors.dart';

class InfoUrl extends StatefulWidget {
  const InfoUrl({super.key});

  @override
  State<InfoUrl> createState() => _InfoUrlState();
}

class _InfoUrlState extends State<InfoUrl> {

  TextEditingController nameController = TextEditingController();
  TextEditingController iconController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Info Url',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text('Add Info Url'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller:  nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller:  iconController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Icon',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller:  urlController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Url',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
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
                    await FirebaseFirestore.instance.collection('info').add({
                      'name': nameController.text,
                      'icon': iconController.text,
                      'url': urlController.text,
                    }).then((value) {
                      Get.back();
                      Get.snackbar('Success', 'Info added successfully');
                    });
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('info').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return GridView.builder(
                itemCount: snapshot.data.docs.length,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              snapshot.data.docs[index]['icon'],
                              width: 80,
                              height: 80,
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              snapshot.data.docs[index]['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async{
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
      ),
    );
  }
}
