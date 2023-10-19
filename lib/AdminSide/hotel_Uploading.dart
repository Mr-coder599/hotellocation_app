import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hotellocation/Pages/HomePage.dart';
import 'package:hotellocation/function/save_locationdb.dart';
// import 'package:hotellocation/Pages/HomePagecationdb.dart';
import 'package:image_picker/image_picker.dart';

class HotelUploading extends StatefulWidget {
  final User user;
  HotelUploading({required this.user});
  // late final User user;

  @override
  State<HotelUploading> createState() => _HotelUploadingState();
}

class _HotelUploadingState extends State<HotelUploading> {
  File? file;
  bool _isLoading = false;
  String localtioname = "";
  String decription = "";
  String longitude = "";
  String latitude = "";
  String phone = "";
  //controllertext
  final hotelnameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phonController = TextEditingController();
  final longituteController = TextEditingController();
  final latitudeController = TextEditingController();
  final emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Hotel Uploading'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (file != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 150,
                            //decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(40),
                            //border: Border.all(color: Colors.blueGrey)),

                            child: Container(
                              width: 120,
                              height: 120,
                              child: Image.file(
                                file!,
                                height: 240,
                                width: 220,
                                fit: BoxFit.cover,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                            //Image.asset('assets/images/logo.jpg'),
                          ),
                        ),
                      ),
                    Center(
                      child: IconButton(
                        onPressed: () {
                          _imageSelection();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Upload hotel picture',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: hotelnameController,
                        // validator: ((value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'please enter some text';
                        //   } else if (value.length < 5) {
                        //     return 'Enter atleast 5 Charecter';
                        //   }

                        //   return null;
                        // }),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Enter Hotel Name'),
                          MinLengthValidator(3,
                              errorText: 'Minimum 3 charecter filled name'),
                        ]),

                        decoration: InputDecoration(
                            hintText: 'Enter Hotel Name',
                            labelText: 'first named',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: descriptionController,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Enter hotel '
                                  'Description'),
                          MinLengthValidator(3,
                              errorText:
                                  'Last name should be atleast 3 charater'),
                        ]),
                        decoration: InputDecoration(
                            hintText: 'Enter hotel '
                                'Description',
                            labelText: 'description ',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Enter email address'),
                          EmailValidator(
                              errorText: 'Please correct email filled'),
                        ]),
                        decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.lightBlue,
                            ),
                            errorStyle: TextStyle(fontSize: 18.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: phonController,
                        keyboardType: TextInputType.phone,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Enter mobile number'),
                          // PatternValidator(r'(^[0,9]{10}$)',
                          //     errorText: 'enter vaid mobile number'),
                        ]),
                        decoration: InputDecoration(
                            hintText: 'Mobile',
                            labelText: 'Mobile',
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: latitudeController,
                        keyboardType: TextInputType.phone,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Enter Latitude value'),
                          // PatternValidator(r'(^[0,9]{10}$)',
                          //     errorText: 'enter vaid mobile number'),
                        ]),
                        decoration: InputDecoration(
                            hintText: 'Latitude Value',
                            labelText: 'Latitude Value',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: longituteController,
                        keyboardType: TextInputType.phone,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: 'Enter Longitude '
                                  'Value'),
                          // PatternValidator(r'(^[0,9]{10}$)',
                          //     errorText: 'enter vaid longitude number'),
                        ]),
                        decoration: InputDecoration(
                            hintText: 'Longitude',
                            labelText: 'Longitude',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)))),
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        // margin: EdgeInsets.fromLTRB(200, 20, 50, 0),

                        child: ElevatedButton(
                          child: Text(
                            'Upload Hotel',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              //      print('form submiitted');
                              _HotelUploadImages();
                            }
                          },
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(30)),
                          // color: Colors.blue,
                        ),
                        //  SizedBox(height: 20),

                        width: MediaQuery.of(context).size.width,

                        height: 50,
                      ),
                    )),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text(
                            'Or Sign In',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }

  //function for both camera and Gallary
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

//update information

  //
  Future HotelUpload(String imageUrl) async {
    // setState(() {
    //   _isLoading = true;
    // });
    Future.delayed(Duration(seconds: 2), () async {
      setState(() {
        _isLoading = true;
      });

      try {
        // Future<void> createPost(
        //     String hotelname,
        //     String latitude,
        //     String longitude,
        //     String desc,
        //     String photo,
        //     String uid,
        //     String phone,
        //     String email) async {
        //   DocumentReference postRef = FirebaseFirestore.instance
        //       .collection('HotelDetails')
        //       .doc(); // Generate a new document ID
        //   await postRef.set({
        //     'uid': uid,
        //     'photo': photo,
        //     'latitude': latitude,
        //     'longitude': longitude,
        //     'desc': desc,
        //     'hotelname': hotelname,
        //     'phone': phone,
        //     'email': email,
        //   });
        // }

        final hotels = Updatelocation(
          photo: imageUrl.toString(),
          hotelname: hotelnameController.text,
          desc: descriptionController.text,
          phone: phonController.text,
          email: emailController.text,
          longitude: longituteController.text,
          latitude: latitudeController.text,
          uid: widget.user.uid,
        );
        await firestore.collection('HotelDetails').doc().set(hotels.toJson());
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Savig Data'),
                  content: Text('Account was created successfully'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok')),
                  ],
                ));
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      user: widget.user,
                    )));
      } on FirebaseException catch (e) {
        print('');
      }
    });
  }

//
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
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  Future<void> _HotelUploadImages() async {
    if (file != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef =
            storage.ref().child('HotelImages/${DateTime.now().toString()}.png');
        UploadTask uploadTask = storageRef.putFile(file!);
        TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
        String imageUrl = await storageSnapshot.ref.getDownloadURL();
        HotelUpload(imageUrl);
      } catch (e) {
        print('Error uploading');
      }
    }
  }
}
