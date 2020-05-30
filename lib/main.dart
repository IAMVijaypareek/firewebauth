import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firewebauth/provider/notifiers/food_notifier.dart';
import 'package:firewebauth/provider/notifiers/user_notifier.dart';
import 'package:firewebauth/provider/user_uid.dart';
import 'package:firewebauth/provider/cartmodelprovider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';

import 'provider/image_upload_provider.dart';
import 'provider/user_provider.dart';

void main() {
  
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode)
      exit(1);
  };
  runApp(
      MyApp(),
    );}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ImageUploadProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (context) => FoodNotifier()),
          ChangeNotifierProvider( create: (context) => UserNotifier('Coding with Curry')),
          ChangeNotifierProvider(create: (context) => UserUID()),
          ChangeNotifierProvider(create: (context) => CartModel()),
          StreamProvider<FirebaseUser>.value(value: FirebaseAuth.instance.onAuthStateChanged)
        ],
        child: MaterialApp(
            title: 'Thailiwala',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.blue),
            home: //SplashScreen()
                AuthService().handleAuth()));
  }
}
