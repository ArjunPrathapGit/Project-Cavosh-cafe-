// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/screens/home.dart';
import 'package:coffee/screens/userSession.dart';
import 'package:flutter/material.dart';

class OrderTracking extends StatefulWidget {
  final String orderedTime;
  final String location;
  const OrderTracking({super.key,required this.orderedTime,required this.location});

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  bool showTracking = true; // Controls the current view
  bool isLoading = false; // Controls loading indicator

  void toggleView() {
    setState(() {
      showTracking = !showTracking; // Toggle between pickup and delivery views
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    

    return SafeArea(
      child: Scaffold(
         backgroundColor:  Color.fromARGB(255,224,225, 221),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 115,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 27, 38, 59),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Opacity(
                      opacity: 0.04,
                      child: Image.asset(
                        "assets/images/Coffee beans set.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 85),
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: showTracking ? null : toggleView,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: showTracking ? Color.fromARGB(255, 13, 27,42) : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Tracking",
                                  style: TextStyle(
                                    color: showTracking ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: showTracking ? toggleView : null,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: !showTracking ?Color.fromARGB(255, 13, 27,42) : Colors.white,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Order details",
                                  style: TextStyle(
                                    color: !showTracking ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 58, vertical: 30),
                    child: Text(
                      "Thank you for the order!",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  showTracking
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.24, horizontal: screenWidth * 0.06),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 218, 235, 249),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: 60,
                                width: screenWidth * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 35),
                                      child: Text("Order Number"),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 33, 67, 94),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
                                        child: Text("75", style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Pickup time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        SizedBox(width: 164),
                                        Text(widget.orderedTime, style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Pick-up location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        
                                        Text(widget.location, style: TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    SizedBox(height: 50),
                                    Row(
                                      children: [
                                        Text(
                                          "Order Tracking",
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 22),
                                    Container(
                                 
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                height: 230,
                                                width: 40,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          width: 40,
                                                          height: 230,
                                                          decoration: BoxDecoration(
                                                            color: const Color.fromARGB(255, 167, 184, 212),
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          height: 160,
                                                          decoration: BoxDecoration(
                                                            color: const Color.fromARGB(255, 129, 151, 188),
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 40,
                                                          height: 87,
                                                          decoration: BoxDecoration(
                                                            color: const Color.fromARGB(255, 45, 53, 66),
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                                                  child: Container(
                                                    
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Order Placed"),
                                                            Container(height: 20,width: 20,
                                                            color: const Color.fromARGB(255, 234, 230, 230),
                                                              child: Icon(Icons.check, color: Colors.red)),
                                                          ],
                                                        ),
                                                        SizedBox(height: 50,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Order Confirmed"),
                                                           Container(height: 18,width: 18,
                                                            color: Color.fromARGB(255, 234, 230, 230)),
                                                          ],
                                                        ),SizedBox(height: 50,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text("Order Delivered"),
                                                            Container(height: 18,width: 18,
                                                            color:  Color.fromARGB(255, 234, 230, 230)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                ElevatedButton(
                 child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'Back Home',
                                        style: TextStyle(color: Colors.white),
                                      ),
                onPressed: isLoading
                                    ? null
                                    : () async {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        String? username =
                                            UserSession().username;

                                        if (username != null &&
                                            username.isNotEmpty) {
                                          final userSnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('Profiles')
                                                  .where('Username',
                                                      isEqualTo: username)
                                                  .get();

                                          if (userSnapshot.docs.isNotEmpty) {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home()),
                                            );
                                          } else {
                                            print("User does not exist.");
                                          }
                                        } else {
                                          print("Username is not available.");
                                        }

                                        setState(() {
                                          isLoading = false;
                                        });
                                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 13, 27,42),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 13),
                  textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 300, horizontal: 40),
                          child: Text(
                            "Delivery options here",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
