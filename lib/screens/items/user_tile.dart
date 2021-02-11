import 'package:flutter/material.dart';
import 'package:subtwo/models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  UserTile({this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
      ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.purple,
          ),
          title: Text(user.fullname),
          subtitle: Text(
            user.studentID,
          ),
        ),
      ),
    );
  }
}
