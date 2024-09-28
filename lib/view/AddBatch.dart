import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/colors.dart';

class AddBatch extends StatefulWidget {
  const AddBatch({super.key, required this.title});
  final String title;

  @override
  State<AddBatch> createState() => _AddBatchState();
}

class _AddBatchState extends State<AddBatch> {

  TextEditingController batchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: const Text('Delete Department'),
                  content: const Text('Are you sure you want to delete this department? All batches under this department will be deleted.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('batch').doc(widget.title).delete().then((value) {
                          Get.back();
                          Navigator.pop(context);
                          Get.snackbar('Success', 'Department deleted successfully');
                        });
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(
                Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              title: const Text('Add Batch'),
              content: TextField(
                controller:  batchController,
                decoration: const InputDecoration(
                  hintText: 'Enter Batch Name',
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
                    List<String> list = [];
                    await FirebaseFirestore.instance.collection('batch').doc(widget.title).get().then((value) {
                      list = value.data()!['list'].cast<String>();
                    });
                    list.add(batchController.text);
                    await FirebaseFirestore.instance.collection('batch').doc(widget.title).update({
                      'list': list,
                    }).then((value) {
                      Get.back();
                      Get.snackbar('Success', 'Batch added successfully');
                    });
                  },
                  child:  Text(
                      'Add',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
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
          stream: FirebaseFirestore.instance.collection('batch').doc(widget.title).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!.data()!['list'].length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(snapshot.data!.data()!['list'][index]),
                      trailing: IconButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text('Delete Batch'),
                              content: const Text('Are you sure you want to delete this batch?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    List<String> list = snapshot.data!.data()!['list'].cast<String>();
                                    list.removeAt(index);
                                    await FirebaseFirestore.instance.collection('batch').doc(widget.title).update({
                                      'list': list,
                                    }).then((value) {
                                      Get.back();
                                      Get.snackbar('Success', 'Batch deleted successfully');
                                    });
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                            Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
      ),
    );
  }
}
