import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:subtwo/screens/parts/create_qr_part.dart';
import 'package:subtwo/screens/parts/my_qr_part.dart';
import 'package:url_launcher/url_launcher.dart';

class QR extends StatefulWidget {
  QR();

  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QR> {
  var result = 'Press The Button';

  Future _scanQR() async {
    try {
      var qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
        launch(result);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = 'Camera permission was denied';
        });
      } else {
        setState(() {
          result = 'Unexpected Error $ex';
        });
      }
    } on FormatException {
      setState(() {
        result = 'You pressed the back button before scanning anything';
      });
    } catch (ex) {
      setState(() {
        result = 'Unexpected Error $ex';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _customContainer("Scanner", _scanQR),
            SizedBox(
              width: 175,
              height: 50,
            ),
            _customContainer(
              "My QR Code",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyQRPart(),
                  ),
                );
              },
            ),
            SizedBox(
              width: 175,
              height: 50,
            ),
            _customContainer(
              "Create QR Code",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateQRPart(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _customContainer(String _title, Function _customOnPressed) {
    return Container(
      width: 250,
      height: 100,
      child: RaisedButton(
        color: Colors.purple[700],
        textColor: Colors.purple[200],
        onPressed: _customOnPressed,
        child: Text(
          _title,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
