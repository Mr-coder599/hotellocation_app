import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/AdminSide/hotel_Uploading.dart';

class AdminLoginPage extends StatefulWidget {
  final User user;
  AdminLoginPage({Key? key, required this.user});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // late final User user;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false; // Track whether login is in progress

  void _Login(BuildContext context) {
    setState(() {
      _isLoading = true; // Start showing progress indicator
    });

    String email = emailController.text;
    String password = passwordController.text;

    // Simulate a network call with a delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Stop showing progress indicator

        if (email == 'hammedmessi@gmail.com' && password == 'Hammed123') {
          // Successful login action, navigate to the next screen or perform an action
          // For now, let's just print a success message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text('Login Successful'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelUploading(
                                user: widget.user,
                              ))),
                  child: Text('OK'),
                ),
              ],
            ),
          );
          print('Login successful');
        } else {
          // Invalid login, show an error message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Error'),
              content: Text('Invalid email or password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text('Admin Login')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/set-of-cheerful.jpg'),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Welcome Admin!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Supply your valid email and password',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16.0),
                _isLoading
                    ? CircularProgressIndicator() // Show progress indicator while logging in
                    : ElevatedButton(
                        onPressed: () => _Login(context),
                        child: Text('Login'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
