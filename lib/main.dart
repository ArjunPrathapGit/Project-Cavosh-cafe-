import 'package:coffee/firebase_options.dart';
import 'package:coffee/screens/HomeScreen.dart';

import 'package:coffee/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        
        GetPage(name: '/login', page: () => Login()), 
        
      ],
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}