import 'package:flutter/material.dart';
import 'package:fys/builders.dart';
import 'package:fys/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromARGB(255, 94, 28, 94),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontFamily: 'Times New Roman',
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            onPrimary: Color.fromARGB(255, 232, 255, 225),
            minimumSize: Size(130, 130),
            textStyle: TextStyle(fontSize: 10, fontFamily: 'alagard'),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class ConectionsScreen extends StatelessWidget {
  const ConectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conexões')),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: Text('Discord')),
          ElevatedButton(onPressed: () {}, child: Text('Steam')),
          ElevatedButton(onPressed: () {}, child: Text('Riot')),
          ElevatedButton(onPressed: () {}, child: Text('Playstation')),
          ElevatedButton(onPressed: () {}, child: Text('Xbox')),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Configurações')),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () =>
                    PushScreen(context, NotificationSettingsScreen()),
                child: Text('Notificações')),
            ElevatedButton(
                onPressed: () => PushScreen(context, PremiumScreen()),
                child: Text('Premium')),
            ElevatedButton(
                onPressed: () => PushScreen(context, PrivacyScreen()),
                child: Text('Privacidade')),
            ElevatedButton(
                onPressed: () => PushScreen(context, AppearenceScreen()),
                child: Text('Aparência'))
          ],
        ));
  }
}

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notificações')),
    );
  }
}

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Premium')),
    );
  }
}

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacidade')),
    );
  }
}

class AppearenceScreen extends StatefulWidget {
  const AppearenceScreen({Key? key}) : super(key: key);

  @override
  State<AppearenceScreen> createState() => _AppearenceScreenState();
}

class _AppearenceScreenState extends State<AppearenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aparencia')),
    );
  }
}
