import 'package:chatmaxapp/providers/users_provider.dart';
import 'package:chatmaxapp/screens/auth_screen.dart';
import 'package:chatmaxapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatmaxapp/providers/auth_privider.dart';

void main() {
  runApp(MyApp());
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    print(notification);
  }
  return null;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
    _firebaseMessaging.subscribeToTopic('recentMessages');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => Auth()),
        ChangeNotifierProvider(create: (BuildContext context) => Users()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.teal[400],
            accentColor: Colors.teal[400],
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.teal[400],
            )),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting )
            return Center(child:CircularProgressIndicator()) ; 
            else if (snapshot.data == null)
              return AuthScreen();
            else
              return Home();
          },
        ),
      ),
    );
  }
}
