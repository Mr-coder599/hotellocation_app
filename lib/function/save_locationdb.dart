class Updatelocation {
  late final String hotelname;
  late final String desc;
  late final String latitude;
  late final String longitude;
  late final String uid;
  late final String photo;
  late final String phone;
  late final String email;
  Updatelocation({
    required this.uid,
    required this.photo,
    required this.latitude,
    required this.longitude,
    required this.desc,
    required this.hotelname,
    required this.phone,
    required this.email,
  });
  factory Updatelocation.froJson(Map<String, dynamic> json) {
    return Updatelocation(
      uid: 'uid',
      photo: 'photo',
      latitude: 'latitude',
      longitude: 'longitude',
      desc: 'desc',
      hotelname: 'hotelname',
      phone: 'phone',
      email: 'email',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'photo': photo,
      'latitude': latitude,
      'longitude': longitude,
      'desc': desc,
      'hotelname': hotelname,
      'phone': phone,
      'email': email,
    };
  }

  // Future<void> createPost(String hotelname, String latitude, String longitude,
  //     String desc, String photo, String uid, String phone, String email) async {
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
}
