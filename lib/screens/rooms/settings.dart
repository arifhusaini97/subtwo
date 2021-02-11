import 'package:flutter/material.dart';
import 'package:subtwo/services/auth.dart';

class Settings extends StatelessWidget {
  Settings();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              _customContainer(context, Icons.delete_forever, "Delete Account"),
              SizedBox(
                height: 25.0,
              ),
              _customContainer(context, Icons.lock, "Logout"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customContainer(
    BuildContext context,
    IconData _optionIcon,
    String _optionName,
  ) {
    final AuthService _auth = AuthService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Material(
          color: Colors.grey[300],
          elevation: 0.0,
          borderRadius: BorderRadius.all(
            Radius.elliptical(5.0, 5.0),
          ),
          child: InkWell(
            onTap: () async {
              await _auth.signOut();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              height: 65.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        _optionIcon,
                        size: 15.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Container(
                        width: 275,
                        child: Text(
                          _optionName,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
