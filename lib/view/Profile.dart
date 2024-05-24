import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.data != null && snapshot.data is User) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${snapshot.data.email}'),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
          }
          return SignInScreen(
            showPasswordVisibilityToggle: true,
            showAuthActionSwitch: false,
            providers: [EmailAuthProvider()],
            headerBuilder: (BuildContext context, BoxConstraints constraints, db) {
              return Container(
                height: 250,
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Image.asset('assets/logo.png'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
