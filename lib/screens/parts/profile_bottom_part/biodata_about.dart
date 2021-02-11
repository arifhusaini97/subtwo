import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/database.dart';

class BiodataAbout extends StatelessWidget {
  final int house;
  BiodataAbout(this.house);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    switch (house) {
      case 1:
        return StreamBuilder<UserModel>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      _contain(
                        "Gender",
                        userData.gender,
                      ),
                      _contain(
                        "Marriage Status",
                        userData.marriageStatus,
                      ),
                      _contain(
                        "Birth Date",
                        DateFormat.yMd().format(userData.birthDate.toDate()),
                      ),
                      _contain(
                        "Student ID",
                        userData.studentID,
                      ),
                    ],
                  ),
                );
              } else {
                return Loading();
              }
            });
        break;
      default:
        return null;
    }
    return null;
  }

  Widget _contain(_title, _descr) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _containTitle(_title),
          _containDescr(_descr),
        ],
      ),
    );
  }

  Widget _containHeader(_header) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Card(
          color: Colors.purple[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _header,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _containTitle(_title) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20, top: 20),
      alignment: Alignment.topLeft,
      width: 110,
      child: Text(
        _title,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15.0,
        ),
      ),
    );
  }

  Widget _containDescr(_descr) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 20, top: 20),
      alignment: Alignment.topLeft,
      width: 250,
      child: Text(
        _descr,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
