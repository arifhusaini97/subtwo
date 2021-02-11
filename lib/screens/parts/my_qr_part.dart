import 'package:flutter/material.dart';
import 'package:subtwo/models/person_model.dart';
import 'package:subtwo/screens/items/qr_generator.dart';
import 'package:subtwo/widgets/parent_provider.dart';

class MyQRPart extends StatefulWidget {
  // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
  MyQRPart();
  @override
  State<StatefulWidget> createState() => MyQRPartState();
}

class MyQRPartState extends State<MyQRPart> {
  final double percent = 0.65;
  String theInfo;
  String _containImage = "${dummyDataPersons[4].avatarUrl}";
  String _containDisplayName = "${dummyDataPersons[4].fullname}";
  String _containDisplayUsername = "@${dummyDataPersons[4].username}";
  String _containDisplayIC = "${dummyDataPersons[4].ic}";
  String _containDisplayProgramme = "${dummyDataPersons[4].occupation}";

  @override
  void initState() {
    super.initState();
    theInfo = 'Please Insert Something';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My QR Code",
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 75.0,
                            height: 75.0,
                            child: Image.asset(
                              _containImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _displayUserInformation(
                                  'Name: ', _containDisplayName),
                              _displayUserInformation(
                                  'Username: ', _containDisplayUsername),
                              _displayUserInformation(
                                  'IC: ', _containDisplayIC),
                              _displayUserInformation(
                                  'Programme: ', _containDisplayProgramme),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ParentProviderQR(
                    theInfo: theInfo,
                    child: QRGenerator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayUserInformation(String _infoType, String _infoContain) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 20.0,
                  width: MediaQuery.of(context).size.width * percent,
                  alignment: Alignment.topLeft,
                  child: Text(
                    _infoType + _infoContain,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
