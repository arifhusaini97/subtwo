import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;

  User({this.uid});
}

class UserModel {
  final String uid;
  final String fullname;
  final String username;
  final String gender;
  final String marriageStatus;
  final String studentID;
  final Timestamp birthDate;

  UserModel(
      {this.uid,
      this.fullname,
      this.username,
      this.gender,
      this.marriageStatus,
      this.studentID,
      this.birthDate});
}
