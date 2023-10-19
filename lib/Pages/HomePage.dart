import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/Api_Location/Navigation_page.dart';
import 'package:hotellocation/function/DrawerUser.dart';
import 'package:hotellocation/function/save_locationdb.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;
  // String get username => null;
  Widget buildWelcome() => StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UserAccount')
            .doc(widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null) {
            return Center(
              child: Text('No data found'),
            );
          }

          String name = data['fullname'] as String; // Cast to String
          String imageURL = data['photo'] as String; // Cast to String

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Hello, $name!'.toUpperCase(),
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageURL),
              ),
            ],
          );
          // );
        },
      );
  //final Updatelocation updatelocation = Updatelocation();
  // Future<Updatelocation> getUserDataFromFirestore() async {
  //   final DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('HotelDetails')
  //       .doc(widget.user.uid)
  //       .get();
  //
  //   return Updatelocation(
  //     hotelname: snapshot['hotelname'],
  //     photo: snapshot['photo'],
  //     uid: 'uid',
  //     latitude: 'latitude',
  //     longitude: 'longitude',
  //     desc: 'desc',
  //     phone: 'phone',
  //     email: 'email',
  //   );
  // }
  // Future getLocation() async {
  //   var firestor = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await firestor.collection("HotelDetails").get();
  //   return qn.docs;
  // }
  Stream<QuerySnapshot> getAllPosts() {
    // return FirebaseFirestore.instance.collection('HotelDetails').snapshots();
    return FirebaseFirestore.instance.collection('HotelDetails').snapshots();
  }
  // Stream<QuerySnapshot> getUserPosts(String userId) {
  //   return FirebaseFirestore.instance
  //       .collection('HotelDetails')
  //       .where('uid', isEqualTo: userId)
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdviserDrawer(
        user: widget.user,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('HomePage'),
        backgroundColor: Colors.black,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(20),
        //   child: Container(
        //     padding: EdgeInsets.all(16),
        //     alignment: Alignment.topLeft,
        //     child: buildWelcome(),
        //   ),
        // ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: getAllPosts(),
          builder: (_, snapshot) {
            //  final hotel = Updatelocation.froJson(data);
            // String imageUrl = snapshot.data?['photo'];
            // String hotelname = snapshot.data?['hotelname'];
            // String largeContent = snapshot.data?['desc'];
            // String phone = snapshot.data?['phone'];
            // String email = snapshot.data?['email'];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<QueryDocumentSnapshot> postDocs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: postDocs.length,
                  itemBuilder: (_, index) {
                    Map<String, dynamic> post =
                        postDocs[index].data() as Map<String, dynamic>;
                    //perform null check error
                    // String title = post['title'] ?? 'No Title';
                    // String description = post['description'] ?? 'No Description';
                    // String imageUrl = post['imageUrl'] ?? '';
                    //end of null check
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        height: 120,
                        child: Card(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  // snapshot.data[index].data()['photo'],
                                  post['photo'],
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                  alignment: Alignment.center,
                                  // width: double.infinity,
                                  filterQuality: FilterQuality.low,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          post['hotelname'],
                                          style: TextStyle(
                                              color: Colors.red, fontSize:
                                          20, overflow: TextOverflow.fade),
                                        ),
                                        Text(
                                          post['phone'],
                                          style: TextStyle(fontSize: 19),
                                        ),
                                        Text(
                                          post['desc'],
                                          style: TextStyle(
                                              overflow: TextOverflow.fade),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // copyToClipboard(context);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NavigationScreen(
                                                            double.parse(post[
                                                                'longitude']),
                                                            double.parse(post[
                                                                'latitude']),
                                                            widget.user)));
                                          },
                                          child: Text(
                                            'Get Location',
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      // Card(
                      //   elevation: 3,
                      //   margin:
                      //       EdgeInsets.symmetric(horizontal: 25, vertical: 19),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         horizontal: 25, vertical: 19),
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: <Widget>[
                      //         Image.network(
                      //           // snapshot.data[index].data()['photo'],
                      //           post['photo'],
                      //           fit: BoxFit.cover,
                      //           height: 150,
                      //           width: double.infinity,
                      //         ),
                      //         SizedBox(
                      //           height: 15,
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: <Widget>[
                      //             Icon(Icons.hotel),
                      //             Text(
                      //               post['hotelname'],
                      //               style: TextStyle(
                      //                   color: Colors.red, fontSize: 20),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: <Widget>[
                      //             Icon(Icons.phone),
                      //             Text(
                      //               post['phone'],
                      //               style: TextStyle(fontSize: 19),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: <Widget>[
                      //             Icon(Icons.email),
                      //             Text(
                      //               post['email'],
                      //               style: TextStyle(fontSize: 19),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           mainAxisAlignment: MainAxisAlignment.start,
                      //           children: [
                      //             Icon(Icons.store_mall_directory_outlined),
                      //             Expanded(
                      //               child: Text(
                      //                 post['desc'],
                      //                 style: TextStyle(
                      //                     overflow: TextOverflow.fade),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         GestureDetector(
                      //           onTap: () {
                      //             // copyToClipboard(context);
                      //             Navigator.of(context).push(MaterialPageRoute(
                      //                 builder: (context) => NavigationScreen(
                      //                     double.parse(post['longitude']),
                      //                     double.parse(post['latitude']),
                      //                     widget.user)));
                      //           },
                      //           child: Text(
                      //             'Get Direction',
                      //             style: TextStyle(
                      //               color: Colors.red,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    );
                  });
            }
          },
        ),
      ),
      // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      //   stream: firestore
      //       .collection('HotelDetails')
      //       .doc(widget.user.uid)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text(snapshot.error?.toString() ?? ''),
      //       );
      //     }
      //     if (snapshot.hasData) {
      //       final data = snapshot.data?.data();
      //       if (data != null) {
      //         final hotel = Updatelocation.froJson(data);
      //         String imageUrl = snapshot.data?['photo'];
      //         String hotelname = snapshot.data?['hotelname'];
      //         String largeContent = snapshot.data?['desc'];
      //         String phone = snapshot.data?['phone'];
      //         String email = snapshot.data?['email'];
      //         return SingleChildScrollView(
      //           child: Card(
      //             elevation: 4,
      //             margin: EdgeInsets.all(12),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: <Widget>[
      //                 Image.network(
      //                   imageUrl,
      //                   fit: BoxFit.cover,
      //                   height: 150,
      //                   width: double.infinity,
      //                 ),
      //                 Text(
      //                   hotelname,
      //                   style: TextStyle(color: Colors.red, fontSize: 20),
      //                 ),
      //                 Text(
      //                   phone,
      //                   style: TextStyle(fontSize: 19),
      //                 ),
      //                 Text(
      //                   email,
      //                   style: TextStyle(fontSize: 19),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Text(largeContent),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         );
      //       }
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      // FutureBuilder<List<Updatelocation>>(
      //   future: getBusinessInfoFromFirestore(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error loading data'));
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.length,
      //         itemBuilder: (context, index) {
      //           return BusinessCard(businessInfo: snapshot.data![index]);
      //         },
      //       );
      //     }
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Perform an action on FAB click
      //     showMenu(
      //       context: context,
      //       position: RelativeRect.fromLTRB(0, 0, 50, 50),
      //       items: [
      //         PopupMenuItem(
      //           child: GestureDetector(
      //             onTap: () {
      //               setState(() {
      //                 Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => HotelUploading(
      //                               user: widget.user,
      //                             )));
      //               });
      //             },
      //             child: Text(
      //               'Upload hotel locations',
      //             ),
      //           ),
      //           value: 'location',
      //         ),
      //         PopupMenuItem(
      //           child: GestureDetector(
      //             onTap: () {
      //               setState(() async {
      //                 await FirebaseAuth.instance.signOut();
      //                 Navigator.pushReplacement(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => LoginPage(
      //                             //     user: widget.user,
      //                             )));
      //               });
      //             },
      //             child: Text(
      //               'Logout',
      //             ),
      //           ),
      //           value: 'location',
      //         ),
      //         // PopupMenuItem(
      //         //   child: Text('Item 2'),
      //         //   value: 'item2',
      //         // ),
      //       ],
      //       elevation: 8.0,
      //     ).then((value) {
      //       if (value == 'item1') {
      //         // Handle Item 1 selection
      //       } else if (value == 'item2') {
      //         // Handle Item 2 selection
      //       }
      //     });
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.red,
      // ),
    );
  }

  Future<List<Updatelocation>> getBusinessInfoFromFirestore() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('HotelDetails').get();

    List<Updatelocation> businessList = [];
    snapshot.docs.forEach((doc) {
      businessList.add(Updatelocation(
        uid: doc[widget.user.uid],
        photo: doc['photo'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        desc: doc['desc'],
        hotelname: doc['hotelname'],
        phone: doc['phone'],
        email: doc['email'],

        // imageUrl: doc['imageUrl'],
        // description: doc['description'],
        // phoneNumber: doc['phoneNumber'],
      ));
    });

    return businessList;
  }
}

class BusinessCard extends StatelessWidget {
  final Updatelocation businessInfo;

  BusinessCard({required this.businessInfo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            businessInfo.photo,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(businessInfo.hotelname.toUpperCase()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              businessInfo.desc,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Phone: ${businessInfo.phone}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Email: ${businessInfo.email}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Longitude: ${businessInfo.longitude}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Latitude: ${businessInfo.latitude}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
