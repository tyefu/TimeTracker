import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_time_tracker/pages/landing/landing_page.dart';
import 'package:flutter_app_time_tracker/pages/signin/signin_page.dart';
import 'package:flutter_app_time_tracker/services/auth.dart';

import 'package:provider/provider.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '過去を見直す',
        theme: ThemeData(

          primarySwatch: Colors.indigo,
          backgroundColor: Colors.grey[800],
        ),
        home: LandingPage(),
      ),
    );
  }
}

