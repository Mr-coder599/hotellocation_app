import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hotellocation/Pages/HomePage.dart';
import 'package:hotellocation/Pages/SigunUp.dart';
import 'package:hotellocation/model/widget/constraint.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    //  required this.user,
    Key? key,
  });
  //final User user;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailaddress = TextEditingController();
  final password = TextEditingController();
  bool _isLoading = false; //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset('assets/images/HL_M65_01.jpg'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome Back,',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Supply Login Crendentials',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailaddress,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        //      email = val;
                      });
                    },
                    validator: (val) {
                      if (val == null) {
                        return "email required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        //   password = val;
                      });
                    },
                    validator: (val) {
                      if (val == null) {
                        return "password required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(height: 16.0),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading =
                                  true; // Start showing progress indicator
                            });
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final UserCredential credential =
                                      await _auth.signInWithEmailAndPassword(
                                    email: emailaddress.text,
                                    password: password.text,
                                  );
                                 // CircularProgressIndicator();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Login Successfully')));
                                  final user = credential.user;
                                  if (user != null) {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //     builder: (context) =>
                                    //     )));
                                  //  CircularProgressIndicator();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                  user: user,
                                                )));
                                  }
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    _isLoading =
                                        false; // Start showing progress indicator
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.message ?? '')));
                                }
                              }
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                  TextStyle(fontSize: 20.0)),
                              elevation: MaterialStateProperty.all<double>(0.0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 50)),
                              fixedSize:
                                  MaterialStateProperty.all(Size(320, 50)),
                              side: MaterialStateProperty.all(
                                BorderSide(color: Colors.orange),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              )),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('OR'),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust the radius as needed
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 90.0), // Adjust padding as needed
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Dont have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "SignUp",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUP()));
                              }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AdminLoginPage(
                  //                  user:widget.user,
                  //                 ///  user: user,
                  //                 )));
                  //   },
                  //   child: Text(
                  //     'Login as an Admin click here',
                  //     style: TextStyle(color: Colors.blue, fontSize: 16),
                  //   ),
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
