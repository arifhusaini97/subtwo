import 'package:flutter/material.dart';
import 'package:subtwo/screens/items/qr_generator.dart';
import 'package:subtwo/widgets/parent_provider.dart';

class CreateQRPart extends StatefulWidget {
  CreateQRPart();
  @override
  State<StatefulWidget> createState() => CreateQRPartState();
}

class CreateQRPartState extends State<CreateQRPart> {
  String theInfo;

  @override
  void initState() {
    super.initState();
    theInfo = 'Please Insert Something';
  }

  _updateInfo(String theInfoStatement) {
    setState(() {
      theInfo = theInfoStatement;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create QR Code')),
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
                  ParentProviderQR(
                    theInfo: theInfo,
                    child: QRGenerator(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(child: Text('The QR code for "$theInfo"')),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Type here',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) {
                          value == ''
                              ? value = '"Please Insert Something"'
                              : value = value;
                          _updateInfo(value);
                          // _inputChecking(input);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
