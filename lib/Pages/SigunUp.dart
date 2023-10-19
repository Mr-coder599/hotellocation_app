import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/Pages/LoginPage.dart';
import 'package:hotellocation/Pages/UserRegistration.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import '../model/widget/constraint.dart';

class SignUP extends StatefulWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final _auth = FirebaseAuth.instance;
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  String emails = '';
  String pass = '';
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Supply Login Crendentials',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailcontroller,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        emails = val;
                      });
                    },
                    validator: (val) {
                      if (val == null) {
                        return "Required EmailAddress";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
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
                        pass = val;
                      });
                    },
                    validator: (val) {
                      val!.isEmpty ? 'Required password' : null;
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState != null) {
                        // if (_formKey.currentState!.validate()) {
                        try {
                          final credential =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailcontroller.text,
                                  password: passwordController.text);
                          final user = credential.user;
                          CircularProgressIndicator(
                            color: Colors.red,
                          );
                          if (user != null) {
                            //    CircularProgressIndicator();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => UserReg(user: user)));
                          }
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? '')));
                        }
                      }
                    },
                    child: Text(
                      'Signup'.toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 20.0)),
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        fixedSize: MaterialStateProperty.all(Size(320, 50)),
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
                  // Text('OR'),
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   icon: FaIcon(FontAwesomeIcons.google),
                  //   label: Text('Sign in with Google'),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     onPrimary: Colors.red,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(
                  //           8.0), // Adjust the radius as needed
                  //     ),
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 10.0,
                  //         horizontal: 90.0), // Adjust padding as needed
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Login",
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage(
                                            //    user: user,
                                            // user: user,
                                            )));
                              }),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
