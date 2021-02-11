import 'package:flutter/material.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

// final _email = TextEditingController(
//   text: '',
// );
// final _password = TextEditingController(
//   text: '',
// );

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 225.0),
                    child: Image.asset(
                      'assets/images/theme/login_theme.jpg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: 400.00,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'English',
                              // style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.language,
                              color: Colors.black,
                              size: 10.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Bahasa Melayu',
                              // style: Theme.of(context).textTheme.body1,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.language,
                              color: Colors.black,
                              size: 10.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'More...',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.brown,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _loginForm(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 15),
                            color: Colors.brown[700],
                            textColor: Colors.brown[200],
                            onPressed: () async {
                              widget.toggleView();
                            },
                            child: Text(
                              'Register New Account',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(0),
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 15.0),
                            color: Colors.brown[700],
                            textColor: Colors.brown[200],
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                              if (result == null) {
                                print('Error signing in');
                              } else {
                                print('Signed in');
                                print(result.uid);
                              }
                            },
                            child: Text(
                              'Login Anonymously',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _loginForm() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 50.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (val) {
                setState(() => _email = val);
              },
              // controller: _email,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
              obscureText: false,
              decoration: const InputDecoration(
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
            TextFormField(
              onChanged: (val) {
                setState(() => _password = val);
              },
              // controller: _password,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
              obscureText: true,
              decoration: const InputDecoration(
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
              height: 20.0,
            ),
            RaisedButton(
              //shape: ShapeBorder.lerp(ShapeBorder(10.0), null, 18.0),
              //shape: ShapeBorder(border: BorderRadius.all(Radius.circular(16.0))),
              padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 16.0),
              color: Colors.brown[700],
              textColor: Colors.brown[200],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() => loading = true);
                  dynamic result =
                      await _auth.loginWithEmailAndPassword(_email, _password);
                  if (result == null) {
                    setState(() {
                      _error = 'Could Not Login with those credential';
                      loading = false;
                    });
                  }
                }
              },
              child: Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Forgotten Password?',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.brown,
              ),
            ),
            SizedBox(height: 12),
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
    );
  }
}
