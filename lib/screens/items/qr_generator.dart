import 'package:flutter/material.dart';
import 'package:subtwo/widgets/parent_provider.dart';

class QRGenerator extends StatefulWidget {
  QRGenerator({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  _QRGeneratorState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Image.network(
          'https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=${ParentProviderQR.of(context).theInfo}'),
      width: 320.0,
      height: 320.0,
    );
  }
}
