import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/house.dart';
import 'package:subtwo/screens/parts/authenticate/authenticate.dart';
import 'package:subtwo/services/database.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<List<UserModel>>.value(
          value: DatabaseService().users, child: House());
    }
  }
}
