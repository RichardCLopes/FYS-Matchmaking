import 'package:flutter/material.dart';

void SwitchScreen(BuildContext context, Widget screen) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => screen));
}

void PushScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
