import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtwo/models/person_model.dart';
import 'package:subtwo/models/organization_model.dart';
import 'package:subtwo/models/event_model.dart';
import 'package:subtwo/models/user_model.dart';
import 'package:subtwo/screens/items/number_animation.dart';
import 'package:subtwo/screens/shared/loading.dart';
import 'package:subtwo/services/database.dart';

const _notiNumberStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
  fontSize: 17,
);

class ProfileTopPart extends StatefulWidget {
  final int house;
  final int id;
  final bool _isOwner;
  ProfileTopPart(this._isOwner, this.house, this.id);
  @override
  _ProfileTopPartState createState() =>
      _ProfileTopPartState(_isOwner, house, id);
}

class _ProfileTopPartState extends State<ProfileTopPart>
    with SingleTickerProviderStateMixin {
  _ProfileTopPartState(this._isOwner, this.house, this.id);

  int house;
  int id;
  bool _isOwner;

  String _containImage;
  String _containDisplayName;
  String _containUserName;
  String _containInfo1;
  String _containInfo2;
  String _containInfo3;
  String _containDescription;
  double _containValueNumber1;
  double _containValueNumber2;
  double _containValueNumber3;
  double _containValueNumber3_1;
  double _containValueNumber3_2;
  int _containValueDecimal1;
  int _containValueDecimal2;
  int _containValueDecimal3_1;
  int _containValueDecimal3_2;
  String _containNameNumber1;
  String _containNameNumber2;
  String _containNameNumber3;

  var _follow = false;
  var _connect = false;
  var _join = false;
  var _attend = false;
  var _attach = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userData = snapshot.data;
            switch (house) {
              case 1:
                _containImage = "${dummyDataPersons[id].avatarUrl}";
                _containDisplayName = userData.fullname;
                _containUserName = "@" + userData.username;
                _containInfo1 = "${dummyDataPersons[id].ranking}";
                _containInfo2 = "${dummyDataPersons[id].department}";
                _containInfo3 = "${dummyDataPersons[id].occupation}";
                _containDescription = "${dummyDataPersons[id].about}";
                _containValueNumber1 = 4.5;
                _containValueNumber2 = 103;
                _containValueNumber3_1 = 50;
                _containValueNumber3_2 = 52;
                _containValueDecimal1 = 1;
                _containValueDecimal2 = 0;
                _containValueDecimal3_1 = 0;
                _containValueDecimal3_2 = 0;
                _containNameNumber1 = 'Attendance Rate';
                _containNameNumber2 = 'Total Activity';
                _containNameNumber3 = 'Attended';
                break;

              default:
                return new Container(
                  width: 0.0,
                  height: 0.0,
                );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Divider(
                  height: 0.0,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 90.0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                      alignment: Alignment.topCenter,
                      child: _containAvatar(house),
                    ),
                    Container(
                      width: 260.0,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  height: 15.0,
                                  width: 260,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _containDisplayName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 15.0,
                            //width: 90,
                            padding: EdgeInsets.only(right: 1.0, left: 1.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              //'@arifhusaini97yg',
                              _containUserName,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          Container(
                            width: 260.0,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    _containInfo1,
                                    //_containUserName,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Icon(
                                  Icons.brightness_1,
                                  color: Colors.black54,
                                  size: 4.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Container(
                                  child: Text(
                                    _containInfo2,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Icon(
                                  Icons.brightness_1,
                                  color: Colors.black54,
                                  size: 4.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Container(
                                  child: Text(
                                    _containInfo3,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Container(
                            height: 45.0,
                            width: 260.0,
                            alignment: Alignment.topLeft,
                            child: Text(
                              _containDescription,
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      //decoration: BoxDecoration(color: Colors.purple),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          NumberAnimation(
                            value: _containValueNumber1,
                            customTextStyle: _notiNumberStyle,
                            decimals: _containValueDecimal1,
                          ),
                          Text(
                            _containNameNumber1,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45.0,
                      //decoration: BoxDecoration(color: Colors.purple),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          NumberAnimation(
                            value: _containValueNumber2,
                            customTextStyle: _notiNumberStyle,
                            decimals: _containValueDecimal2,
                          ),
                          Text(
                            _containNameNumber2,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 45.0,
                      //decoration: BoxDecoration(color: Colors.purple),
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              NumberAnimation(
                                value: _containValueNumber3_1,
                                customTextStyle: _notiNumberStyle,
                                decimals: _containValueDecimal3_1,
                              ),
                              Text("/"),
                              NumberAnimation(
                                value: _containValueNumber3_2,
                                customTextStyle: _notiNumberStyle,
                                decimals: _containValueDecimal3_2,
                              ),
                            ],
                          ),
                          Text(
                            _containNameNumber3,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _containButton(_isOwner),
                Divider(
                  height: 0.0,
                  color: Colors.black54,
                ),
                Divider(
                  height: 0.0,
                  color: Colors.black54,
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }

  Widget _containAvatar(house) {
    if (house == 1 || house == 2 || house == 4) {
      return CircleAvatar(
        radius: 35.0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.purple,
        backgroundImage: AssetImage(_containImage),
      );
    } else if (house == 3) {
      return Container(
        width: 75.0,
        height: 75.0,
        child: Image.asset(
          _containImage,
          fit: BoxFit.fill,
        ),
      );
    }
    return null;
  }

  Widget _containButton(_isOwner) {
    switch (_isOwner) {
      case false:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: _button1(house),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 10.0,
              ),
              child: _button2(house),
            ),
          ],
        );
        break;
      default:
        return Container(height: 15.0, width: 0.0);
    }
  }

  Widget _button1(house) {
    if (house == 1) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_follow == false) {
                _follow = true;
              } else if (_follow == true) {
                _follow = false;
              }
            },
          );
        },
        child: Text(
          _follow ? 'Unfollow' : 'Follow',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 2) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_follow == false) {
                _follow = true;
              } else if (_follow == true) {
                _follow = false;
              }
            },
          );
        },
        child: Text(
          _follow ? 'Unfollow' : 'Follow',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 3) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_follow == false) {
                _follow = true;
              } else if (_follow == true) {
                _follow = false;
              }
            },
          );
        },
        child: Text(
          _follow ? 'Unfollow' : 'Follow',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 4) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_follow == false) {
                _follow = true;
              } else if (_follow == true) {
                _follow = false;
              }
            },
          );
        },
        child: Text(
          _follow ? 'Unfollow' : 'Follow',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return null;
  }

  Widget _button2(house) {
    if (house == 1) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_connect == false) {
                _connect = true;
                _follow = true;
              } else if (_connect == true) {
                _connect = false;
              }
            },
          );
        },
        child: Text(
          _connect ? 'Disconnect' : 'Connect',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 2) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_join == false) {
                _join = true;
                _follow = true;
              } else if (_join == true) {
                _join = false;
              }
            },
          );
        },
        child: Text(
          _join ? 'Leave' : 'Join',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 3) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_attend == false) {
                _attend = true;
                _follow = true;
              } else if (_attend == true) {
                _attend = false;
              }
            },
          );
        },
        child: Text(
          _attend ? 'Cancel' : 'Attend',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (house == 4) {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 8.0,
        color: Colors.purple,
        textColor: Colors.white,
        onPressed: () {
          setState(
            () {
              if (_attach == false) {
                _attach = true;
                _follow = true;
              } else if (_attach == true) {
                _attach = false;
              }
            },
          );
        },
        child: Text(
          _attach ? 'Unattach' : 'Attach',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return null;
  }
}
