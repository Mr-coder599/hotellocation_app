import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotellocation/AdminSide/hotel_Uploading.dart';
import 'package:hotellocation/Pages/HomePage.dart';
import 'package:hotellocation/Pages/LoginPage.dart';
import 'package:hotellocation/Pages/OpenStreetMap/openStreetMap.dart';
import 'package:hotellocation/Pages/ProfilePage.dart';
import 'package:hotellocation/function/settingpPage.dart';

class AdviserDrawer extends StatelessWidget {
  AdviserDrawer({Key? key, required this.user}) : super(key: key);
  final User user;
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  VoidCallback? onClicked;
  //late User user;
  // late final User user;
  //AdviserDrawer({super.key});
  final TextEditingController _searchController = TextEditingController();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('HotelDetails');
  QuerySnapshot? _searchResults;
  void _searchByName(String name) async {
    final snapshot = await _usersCollection
        .where('hotelname', isGreaterThanOrEqualTo: name)
        .get();
    //   setState(() {
    _searchResults = snapshot;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search hotel..',
                  hintStyle: const TextStyle(color: Colors.white),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Expanded(
                        child: _searchResults != null
                            ? ListView.builder(
                                itemCount: _searchResults!.docs.length,
                                itemBuilder: (context, index) {
                                  final doc = _searchResults!.docs[index];
                                  return ListTile(
                                    title: Text(doc['hotelname']),
                                    // Display other user details as needed
                                  );
                                },
                              )
                            : const Center(child: Text('Enter a name to search')),
                      );
                    },
                    child: const Icon(Icons.search),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  // Handle search logic here
                  // You can update the UI or perform a search action
                },
              ),
            ),
            buildMenuItem(
              text: 'My Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Upload Hotel',
              icon: Icons.reviews,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'All Hotels',
              icon: Icons.update,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Open Street Map',
              icon: Icons.map,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(
              height: 24,
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem(
      {required String text,
      required IconData icon,
      required Function() onClicked}) {
    final color = Colors.white;
    final hovercolr = Colors.white;
    // VoidCallback? onClicked;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hovercolr,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 4:
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
        break;
      case 2:
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SettingsPage2(
                //    user: user,
                )));
        break;
      case 3:

        ///    Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )));
        break;

      case 0:
        //   Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfilePage(user: user)));
        break;
      case 1:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HotelUploading(
                      user: user,
                    )));
        break;
      case 5:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OpenStreetMap(
                    //  user: user,
                    )));
        break;
    }
  }
}
