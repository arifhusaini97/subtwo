import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subtwo/models/user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  Future updateUserData(String fullname, String username, String gender,
      String marriageStatus, String studentID, Timestamp birthDate) async {
    return await usersCollection.document(uid).setData({
      'fullname': fullname,
      'username': username,
      'gender': gender,
      'marriageStatus': marriageStatus,
      'studentID': studentID,
      'birthDate': birthDate,
    });
  }

  // user list from snapshot
  List<UserModel> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserModel(
        fullname: doc.data['fullname'] ?? '',
        username: doc.data['username'] ?? '',
        gender: doc.data['gender'] ?? '',
        marriageStatus: doc.data['marriageStatus'] ?? '',
        studentID: doc.data['studentID'] ?? '',
        birthDate: doc.data['birthDate'] ?? DateTime.now(),
      );
    }).toList();
  }

  //userData from snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: uid,
      fullname: snapshot.data['fullname'],
      username: snapshot.data['username'],
      studentID: snapshot.data['studentID'],
      gender: snapshot.data['gender'],
      marriageStatus: snapshot.data['marriageStatus'],
      birthDate: snapshot.data['birthDate'],
    );
  }

  Stream<List<UserModel>> get users {
    return usersCollection.snapshots().map(_userListFromSnapshot);
  }

  //get user doc stream
  Stream<UserModel> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
