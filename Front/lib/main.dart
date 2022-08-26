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
/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
          child: Column(
        children: [
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, CreateAccountScreen()),
                  child: Text("criar conta")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, ShootPickScreen()),
                  child: Text("login"))
            ],
          )
        ],
      )),
    ));
  }
}
*/

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar conta')),
      body: Center(
          child: Column(
        children: [
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, MyHomePage()),
                  child: Text("cancelar")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, MyHomePage()),
                  child: Text("completar"))
            ],
          )
        ],
      )),
    );
  }
}

class ShootPickScreen extends StatefulWidget {
  const ShootPickScreen({Key? key}) : super(key: key);

  @override
  State<ShootPickScreen> createState() => _ShootPickScreenState();
}

class _ShootPickScreenState extends State<ShootPickScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (() => PushScreen(context, SideMenuScreen())),
            icon: Icon(Icons.menu)),
        title: Text('shoot pick'),
        actions: <Widget>[
          IconButton(
              onPressed: (() => PushScreen(context, UserProfileScreen())),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, MessagesScreen()),
                  child: Text("mensagens")),
              ElevatedButton(onPressed: () {}, child: Text("shoot pick")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, ComunityScreen()),
                  child: Text("comunidades")),
            ],
          )
        ],
      )),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (() => PushScreen(context, SideMenuScreen())),
            icon: Icon(Icons.menu)),
        title: Text('messages'),
        actions: <Widget>[
          IconButton(
              onPressed: (() => PushScreen(context, UserProfileScreen())),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("mensagens")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, ShootPickScreen()),
                  child: Text("shoot pick")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, ComunityScreen()),
                  child: Text("comunidades")),
            ],
          )
        ],
      )),
    );
  }
}

class ComunityScreen extends StatefulWidget {
  const ComunityScreen({Key? key}) : super(key: key);

  @override
  State<ComunityScreen> createState() => _ComunityScreenState();
}

class _ComunityScreenState extends State<ComunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() => PushScreen(context, SideMenuScreen())),
            icon: Icon(Icons.menu)),
        centerTitle: true,
        title: Text('Comunidades'),
        actions: <Widget>[
          IconButton(
              onPressed: (() => PushScreen(context, UserProfileScreen())),
              icon: Icon(Icons.account_circle_outlined)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text('placeholder'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, MessagesScreen()),
                  child: Text("mensagens")),
              ElevatedButton(
                  onPressed: () => SwitchScreen(context, ShootPickScreen()),
                  child: Text("shoot pick")),
              ElevatedButton(onPressed: () {}, child: Text("comunidades")),
            ],
          )
        ],
      )),
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('perfil'),
      ),
    );
  }
}

class SideMenuScreen extends StatelessWidget {
  const SideMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Side Menu')),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () => PushScreen(context, ConectionsScreen()),
                child: Text('Conexões')),
            ElevatedButton(
                onPressed: () => PushScreen(context, UserProfileScreen()),
                child: Text('Editar Perfil')),
            ElevatedButton(
                onPressed: () => PushScreen(context, SettingsScreen()),
                child: Text('Configurações')),
            ElevatedButton(
                onPressed: () => SwitchScreen(context, MyHomePage()),
                child: Text('Sair'))
          ],
        ));
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
