import 'package:flutter/material.dart';
import 'package:subtwo/screens/shared/constants.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String _email = '';
  String _password = '';
  String _passwordConfirmation = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('Register with Subtwo'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
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
                              setState(() => _email = value);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: false,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Email',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Email is required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            onChanged: (String value) {
                              setState(() => _password = value);
                            },
                            // controller: _password,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Password',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Enter a password 6+ character long';
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
                              setState(() => _passwordConfirmation = value);
                            },
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: 'Password Confirmation',
                            ),
                            validator: (String value) {
                              if (value.trim().isEmpty) {
                                return 'Password Confirmation is required';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
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
                                if (_password != _passwordConfirmation) {
                                  setState(() {
                                    _error = 'Your password is not matching';
                                    _password = '';
                                    _passwordConfirmation = '';
                                  });
                                } else {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          _email, _password);
                                  if (result == null) {
                                    setState(() {
                                      _error = 'Please supply a valid email';
                                      loading = false;
                                    });
                                  }
                                }
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
  }
}
