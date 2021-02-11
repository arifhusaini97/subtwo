import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/items/user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserModel>>(context) ?? [];

    //debug command
    //print(users.documents);

    // for (var doc in users.documents) {
    //   print(doc.data);
    // }

    // users.forEach((user) {
    //   print(user.fullname);
    //   print(user.username);
    //   print(user.gender);
    //   print(user.marriageStatus);
    //   print(user.studentID);
    //   print(user.birthDate);
    // });

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return UserTile(
          user: users[index],
        );
      },
    );
  }
}
