import 'package:e_shoppie_admin/screens/admin_home.dart';
import 'package:e_shoppie_admin/screens/admin_screen.dart';
import 'package:e_shoppie_admin/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      // home: AdminPage(),
      home: DefaultTabController(
        length: 2,
        child: AdminHome(),
      ),
    );
  }
}
