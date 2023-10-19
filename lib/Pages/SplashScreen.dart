import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/Pages/HomePage.dart';
import 'package:hotellocation/Pages/LoginPage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  //late final User user;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 13), () {
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => WelcomePage()));
    // });
    late final StreamSubscription _subscription;
    Future.delayed(const Duration(seconds: 10), () {
      _subscription = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomePage(
                    user: user,
                  )));
          // } else if (user != null) {
          //   Navigator.of(context).pushReplacement(
          //
          //       MaterialPageRoute(builder: (context) => Dashboard(user: user)));
          return;
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginPage(
                  // user: user,
                  //user: user,
                  //   user: widget.user,
                  )));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 190,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.jpg'),
              radius: 60,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Hotel Location Management System'.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            Spacer(),
            CircularProgressIndicator(
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Supervised by Mr. Etudaiye',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      )),
    );
  }
}
