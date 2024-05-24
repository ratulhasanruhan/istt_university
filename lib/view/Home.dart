import 'package:flutter/material.dart';
import 'package:istt_university/util/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12),

            ),
          )
        ],
      ),
    );
  }
}
