import 'package:coffee/screens/login.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade200,
            child: Opacity(
              opacity: 0.02,
              child: Image.asset(
                "assets/images/coffeeeeeee.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center the "Cavosh" text
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Text(
              "Cavosh",
              style: GoogleFonts.raleway(
                fontSize: 60,
                color: Color.fromARGB(250, 107, 62, 46),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Positioning the second text lower
          Positioned(
            top: screenSize.height * 0.25,
            left: 0,
            right: 0,
            child: Text(
              "Where the Coffee\nMeets Passion",
              style: GoogleFonts.roboto(
                fontSize: 24,
                color:  Color.fromARGB(250, 107, 62, 46),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Positioning the button at the bottom
          Padding(
            padding: const EdgeInsets.only(top: 300,left: 70),
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.brown.shade100,
                borderRadius: BorderRadius.circular(20)

              ),
              height: 300,
              width: 250,
              
              child: Icon(Icons.coffee,size: 251,color: const Color.fromARGB(255, 45, 35, 31),),
            
            ),
          ),
          
          Positioned(
            bottom: screenSize.height * 0.05, // Adjust this value as needed
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 41),
              child: ElevatedButton(
                child: Text('Get started',style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(249, 90, 59, 48),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
