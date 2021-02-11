import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/shared/constants.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/database.dart';

class FormConfirmation extends StatefulWidget {
  const FormConfirmation({Key key}) : super(key: key);

  @override
  _FormConfirmationState createState() => _FormConfirmationState();
}

class _FormConfirmationState extends State<FormConfirmation> {
  final _formKey = GlobalKey<FormState>();
  final List<String> levels = ['0', '1', '2', '3', '4'];
  String _currentLevel;
  String _currentFullname;
  int _currentSatisfaction;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Confirmation',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.fullname,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentFullname = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentLevel ?? '0',
                    items: levels.map((level) {
                      return DropdownMenuItem(
                          value: level, child: Text('Level $level'));
                    }).toList(),
                    onChanged: (val) => setState(() => _currentLevel = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentSatisfaction ?? 100).toDouble(),
                    activeColor: Colors.purple,
                    inactiveColor: Colors.purpleAccent,
                    min: 1,
                    max: 100,
                    divisions: 100,
                    onChanged: (val) =>
                        setState(() => _currentSatisfaction = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentFullname ?? userData.fullname,
                          userData.username,
                          userData.gender,
                          userData.marriageStatus,
                          userData.studentID,
                          userData.birthDate,
                        );
                        Navigator.pop(context);
                      }
                      // print(_currentFullname);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
