import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/pages/forms/form_profile_declaration.dart';
import 'package:subtwo/screens/rooms/calendar.dart';
import 'package:subtwo/screens/rooms/profile.dart';
import 'package:subtwo/screens/rooms/qr.dart';
import 'package:subtwo/screens/rooms/settings.dart';
import 'package:subtwo/screens/rooms/user_list.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/database.dart';

class House extends StatefulWidget {
  @override
  _HouseState createState() => _HouseState();
}

class _HouseState extends State<House> with SingleTickerProviderStateMixin {
  int currentIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    QR(),
    Profile(true, 1, 4),
    Calendar(),
    UserList(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserModel>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data;
          return userData.fullname == 'fullname'
              ? FormProfileDeclaration()
              : Scaffold(
                  body: SafeArea(child: _widgetOptions[currentIndex]),
                  bottomNavigationBar: bottomNavBar(),
                );
        } else {
          return Loading();
        }
      },
    );
  }

  Widget bottomNavBar() {
    final List<BottomNavigationBarItem> items = [
      // First item
      BottomNavigationBarItem(
        icon: Icon(
          Icons.center_focus_weak,
        ),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person_pin,
        ),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.event,
        ),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
        ),
        title: Text(''),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        title: Text(''),
      ),
    ];

    return BottomNavigationBar(
      items: items,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,
      iconSize: 24.0,
      showSelectedLabels: true,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedFontSize: 0.0,
      type: BottomNavigationBarType.fixed,
      elevation: 18.0,
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: Colors.purple,
        size: 40.0,
      ),
      unselectedIconTheme: IconThemeData(color: Colors.black),
    );
  }
}
