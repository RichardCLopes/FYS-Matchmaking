import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fys/builders.dart';
import 'package:fys/http.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fys/pages/Messages.dart';

class QrReader extends StatefulWidget {
  const QrReader({super.key});

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  String readID = "";
  Future<void> scanQRCodeNormal() async {
    String QRScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      QRScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      QRScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (QRScanRes != '-1') {
      readID = jsonDecode(QRScanRes)['_id'];
      if (readID != null && readID.isNotEmpty) {
        matchQR(jsonDecode(readID)['_id']).then((value) {
          if (value == 200)
            SwitchScreen(context, MessagesPage());
          else
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Usuário não encontrado'),
                content: const Text('QR code inválido, ler denovo'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            Text(
              "Dar match em outro usuário através de QR Code:",
              style: TextStyle(
                fontFamily: 'alagard',
                color: Colors.yellow,
                fontSize: 26,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 120, 15, 30),
              height: 70,
              width: 300,
              child: ElevatedButton(
                onPressed: (() => scanQRCodeNormal()),
                child: Text(
                  "ler",
                  style: TextStyle(
                    fontFamily: 'alagard',
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 40, 6, 49),
                  side: BorderSide(
                      color: Color.fromARGB(255, 51, 225, 255), width: 1),
                  // ignore: unnecessary_new
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
