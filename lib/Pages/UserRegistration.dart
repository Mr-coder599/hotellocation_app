import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/Pages/LoginPage.dart';
import 'package:hotellocation/function/dbDatabase.dart';
import 'package:image_picker/image_picker.dart';

class UserReg extends StatefulWidget {
  UserReg({required this.user});
  final User user;
  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  File? file;
  bool loading = false;
  String dropdownvalue = 'Male';
  String dropdownbalues = 'Indigene';
  var items = [
    'Male',
    'Female',
  ];
  var position = ['Visitor', 'Indigene'];
  final _formKey = GlobalKey<FormState>();
  late bool isPasswordTextField = true;
  bool showPassword = true;

  final phoneNumber = TextEditingController();
  final emailaddress = TextEditingController();
  final passwordcontroller = TextEditingController();
  final fullnames = TextEditingController();
  final genderController = TextEditingController();
  final positionController = TextEditingController();
  // get textInputDecoration => null;
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Color(0xffEEF5),
      //   title: Text(
      //     'User Registration'.toUpperCase(),
      //     style: TextStyle(color: Colors.deepPurple),
      //   ),
      //   // elevation: 0.0,
      // ),
      body: SingleChildScrollView(
        child: CupertinoPageScaffold(
          // backgroundColor: Color(0xffEEF5FC),
          //CupertinoColors.secondarySystemFill,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Image.asset('assets/images/HL_M65_01.jpg'),
                        SizedBox(
                          height: 20,
                        ),
                        if (file != null)
                          Container(
                            width: 120,
                            height: 120,
                            child: Image.file(
                              file!,
                              height: 240,
                              width: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                        IconButton(
                          onPressed: () {
                            _imageSelection();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            controller: fullnames,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'FullName',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required Fullname';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text('Select type '),
                            value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                genderController.text = newValue;
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButton(
                            isExpanded: true,
                            hint: Text('Select type '),
                            value: dropdownbalues,
                            icon: Icon(Icons.keyboard_arrow_down),
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            items: position.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownbalues = newValue!;
                                positionController.text = newValue;
                              });
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: phoneNumber,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required phone Number';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailaddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                            validator: (val) {
                              if (val!.isNotEmpty) {
                                return null;
                              } else {
                                return 'Required email';
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.deepPurple,
                        child: const FittedBox(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                _uploadImageToFirebase();
                              }
                            }
                          });
                        })),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _imageSelection() async {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Choose Images'),
            content: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _ImageFromGallery(context);
                    },
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Gallery'),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.camera,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        _ImageFromCamera(context);
                      },
                      child: Row(
                        children: <Widget>[
                          Text('Camera'),
                          SizedBox(
                            width: 25,
                          ),
                          Icon(
                            Icons.camera_alt,
                            size: 20,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }

  void _ImageFromGallery(BuildContext context) async {
    final pickImage = ImagePicker();
    final imagepicked = await pickImage.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        file = File(imagepicked.path);
      });
    }
    Navigator.of(context).pop();
  }

  void _ImageFromCamera(BuildContext context) async {
    final pickImage = ImagePicker();
    final imagepicked = await pickImage.pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      setState(() {
        file = File(imagepicked.path);
      });
    }
    Navigator.of(context).pop();
  }
  //Databse

  Future SaveRecord(String imageUrl) async {
    setState(() {
      loading = true;
    });
    try {
      final RegisterUsers = UserAccount(
        uid: widget.user.uid,
        fullname: fullnames.text,
        gender: genderController.text,
        phoneNo: phoneNumber.text,
        position: positionController.text,
        email: emailaddress.text,
        photo: imageUrl.toString(),
      );
      await firestore
          .collection('UserAccount')
          .doc(RegisterUsers.uid)
          .set(RegisterUsers.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Saving Record'),
                content: Text(
                  'Data Uploaded',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage(
                                    //  user: widget.user,
                                    )));
                      },
                      child: Text('Ok')),
                ],
              ));
    } on FirebaseAuthException catch (e) {}
  }

  //saving images with Record Data
  Future<void> _uploadImageToFirebase() async {
    if (file != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef =
            storage.ref().child('UserImages/${DateTime.now().toString()}.png');
        UploadTask uploadTask = storageRef.putFile(file!);
        TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
        String imageUrl = await storageSnapshot.ref.getDownloadURL();
        SaveRecord(imageUrl);
      } catch (e) {
        print('Error uploading');
      }
    }
  }
}
