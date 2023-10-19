import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/Pages/LoginPage.dart';
import 'package:hotellocation/Pages/SigunUp.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF5FC),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 210,
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/HL_M65_01.jpg'),
                radius: 90,
              ),
              Spacer(),
              Text(
                'Build Awesome Apps',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                'Let put your creativity on the \n development highway',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                    //user: widget.user,
                                    )));
                      },
                      child: Text('LOGIN')),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignUP()));
                      },
                      child: Text('SIGNUP'))
                ],
              ),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
