import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/shared/constants.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/auth.dart';
import 'package:subtwo/services/database.dart';

class FormProfileDeclaration extends StatefulWidget {
  final Function toggleView;

  FormProfileDeclaration({this.toggleView});

  @override
  _FormProfileDeclarationState createState() => _FormProfileDeclarationState();
}

class _FormProfileDeclarationState extends State<FormProfileDeclaration> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String _fullname = '';
  String _username = '';
  String _studentID = '';
  final List<String> _gender = ['Male', 'Female', 'Rather Not Say'];
  String _currentGender;
  final List<String> _marriageStatus = ['Single', 'Married', 'Rather Not Say'];
  String _currentMarriageStatus;
  Timestamp _birthDate = Timestamp.now();
  final format = DateFormat('EEE, MMM d, ' 'yy');
  String _error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return loading
        ? Loading()
        : StreamBuilder<UserModel>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel userData = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Text('Profile Declaration'),
                  ),
                  backgroundColor: Colors.purple[100],
                  body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 50.0,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  onChanged: (String value) {
                                    setState(() => _fullname = value);
                                  },
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                  obscureText: false,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Fullname',
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Fullname is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    setState(() => _username = value);
                                  },
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                  obscureText: false,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Username',
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Username is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  onChanged: (String value) {
                                    setState(() => _studentID = value);
                                  },
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                  ),
                                  obscureText: false,
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Student ID',
                                  ),
                                  validator: (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Student ID is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                //dropdown
                                DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Gender',
                                  ),
                                  value: _currentGender,
                                  items: _gender.map((gender) {
                                    return DropdownMenuItem(
                                        value: gender, child: Text(gender));
                                  }).toList(),
                                  onChanged: (val) =>
                                      setState(() => _currentGender = val),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                //dropdown
                                DropdownButtonFormField(
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Marriage Status',
                                  ),
                                  value: _currentMarriageStatus,
                                  items: _marriageStatus.map((marriageStatus) {
                                    return DropdownMenuItem(
                                        value: marriageStatus,
                                        child: Text(marriageStatus));
                                  }).toList(),
                                  onChanged: (val) => setState(
                                      () => _currentMarriageStatus = val),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DateTimeField(
                                  decoration: textInputDecoration.copyWith(
                                    labelText: 'Birth Date',
                                  ),
                                  format: format,
                                  onChanged: (date) => setState(() {
                                    _birthDate = Timestamp.fromDate(date);
                                  }),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                RaisedButton(
                                  //shape: ShapeBorder.lerp(ShapeBorder(10.0), null, 18.0),
                                  //shape: ShapeBorder(border: BorderRadius.all(Radius.circular(16.0))),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 90.0, vertical: 16.0),
                                  color: Colors.brown[700],
                                  textColor: Colors.brown[200],
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() => loading = true);
                                      await DatabaseService(uid: user.uid)
                                          .updateUserData(
                                        _fullname,
                                        _username,
                                        _currentGender,
                                        _currentMarriageStatus,
                                        _studentID,
                                        _birthDate,
                                      );
                                      // Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  _error,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Loading();
              }
            });
  }
}
