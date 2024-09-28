import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:istt_university/util/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Infos extends StatelessWidget {
  const Infos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'ISTT',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('info').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
              itemCount: snapshot.data.docs.length,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async{
                    await launchUrl(Uri.parse(snapshot.data.docs[index]['url']), mode: LaunchMode.inAppBrowserView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: snapshot.data.docs[index]['icon'],
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
