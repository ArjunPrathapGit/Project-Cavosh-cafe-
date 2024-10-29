
import 'package:coffee/screens/HomeScreen.dart';
import 'package:coffee/screens/home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is logged in, go to HomeScreen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
      } else {
        // User is not logged in, go to Login screen
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.brown.shade100,
         
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              
              // Background image
              // Positioned.fill(
              //   child: Image.asset(
              //     "assets/images/Splash_image.png",
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Welcome To",style: TextStyle(fontSize: 20,color: Colors.brown))),
                 
                  Center(child: Text("Cavosh",style: TextStyle(fontSize: 35,color: Colors.brown,fontWeight:FontWeight.bold),)),
                ],
              ),
              
            
              // Lottie animation
              Align(
                alignment: Alignment(0.0, -0.9), 
                child: Lottie.network(
                  "https://lottie.host/bdee5ed6-4174-44f7-92bb-83d7bc3f9c2c/RxxLkuxbNQ.json",
                  controller: _controller,
                  frameRate: FrameRate.max,
                  onLoaded: (composition) {
                    _controller
                      ..duration = Duration(
                          milliseconds:
                              (composition.duration.inMilliseconds / 1).round())
                      ..repeat();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 