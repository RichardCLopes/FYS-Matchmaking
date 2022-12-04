import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fys/builders.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x44000000),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              Text(
                "Seja adicionado atravez do QR code abaixo:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'alagard',
                  color: Colors.yellow,
                  fontSize: 25,
                ),
              ),
              Container(
                  padding: EdgeInsets.all(25),
                  child: Image.asset("assets/images/qr_Placeholder.png"))
            ],
          ),
        ));
  }
}
