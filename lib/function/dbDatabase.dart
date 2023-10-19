class UserAccount {
  late final String uid;
  late final String fullname;
  late final String gender;
  late final String phoneNo;
  late final String position;
  late final String email;
  late final String photo;

  UserAccount({
    required this.uid,
    required this.fullname,
    required this.gender,
    required this.phoneNo,
    required this.position,
    required this.email,
    required this.photo,
  });

  factory UserAccount.froJson(Map<String, dynamic> json) {
    return UserAccount(
      uid: json['uid'],
      fullname: json['fullname'],
      gender: json['gender'],
      phoneNo: json['phoneNo'],
      position: json['position'],
      email: json['email'],
      photo: json['photo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullname': fullname,
      'gender': gender,
      'phoneNo': phoneNo,
      'position': position,
      'email': email,
      'photo': photo,
    };
  }
}

// ignore: camel_case_types
