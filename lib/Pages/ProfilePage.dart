import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/function/dbDatabase.dart';

import '../function/DrawerUser.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firestore = FirebaseFirestore.instance;
  void _openBottomSheet() {
    // DocumentSnapshot snapshot
    TextEditingController firstnameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: firstnameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'FullName',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Gender',
                      labelText: 'Gender'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Email'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: positionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Position'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Phone'),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Update data in Firestore
                    firestore
                        .collection('UserAccount')
                        .doc(widget.user.uid)
                        .update({
                      'fullname': firstnameController.text,
                      'gender': genderController.text,
                      'email': emailController.text,
                      'position': positionController.text,
                      'phoneNo': phoneController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      'Record Updated Successfuly',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )));
                    Navigator.pop(context); // Close the BottomSheet
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AdviserDrawer(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _openBottomSheet();
                });
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: firestore
            .collection('UserAccount')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? ''),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data();

            if (data != null) {
              final Details = UserAccount.froJson(data);

              String imageURL = data['photo'] as String;
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        'Profile Picture',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                      Center(
                          child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10)),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(imageURL),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(width: 4, color: Colors.green),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                              ))
                        ],
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        'Personal Information',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      )),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'FullName(s)'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(width: 10,),
                          Text(
                            '${Details.fullname.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Gender'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Details.gender.toUpperCase()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'EmailAddress'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Details.email}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Position'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Details.position.toUpperCase()}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Phone No'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${Details.phoneNo}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        height: 500,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Spacer(),
                            // OutlinedButton(
                            //     onPressed: () {
                            //       // Navigator.pushReplacement(
                            //       //     context,
                            //       //     MaterialPageRoute(
                            //       //         builder: (context) => LoginPage(
                            //       //             //user: widget.user,
                            //       //             )));
                            //     },
                            //     child: Text('LOGIN')),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: Text('Edit Profile'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );

          //buttonsheet

          //end of buttonsheet
        },
      ),
    );
  }
}
