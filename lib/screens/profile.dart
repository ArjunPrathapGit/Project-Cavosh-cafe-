// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:coffee/controllers/profile_notifcn-swtch.dart';
import 'package:coffee/screens/userSession.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
   Profile({super.key});
  void logout() {
  // Your logout logic here (e.g., clear user session)
  
  // Navigate to the login page
  Get.offAllNamed('/login'); // This will remove the previous routes and navigate to /login
}
String? username = UserSession().getUsername();

  @override
  Widget build(BuildContext context) {
    final SwitchController switchController = Get.put(SwitchController());
    // ignore: unused_local_variable
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.only(left: 25, top: 73),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey.shade200,
                      ),
                      width: screenWidth * 0.87,
                      height: 80,
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 70,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profilelogo.jpg"),
                          ),
                        ),
                        title: Text(
                          username ?? "User",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("⭐124 points"),
                        trailing: Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:  Colors.grey.shade50,
                      ),
                      width: screenWidth * 0.87,
                      height: 230,
                      child: Column(
                        children: [
                          Card(shadowColor: Colors.white,
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              height: 38, 
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.account_balance,color: const Color.fromARGB(255, 69, 109, 145),),
                                    SizedBox(width: 50,),
                                    Text("Account details"),
                                
                                  ],
                                ),
                              )
                           
                            ),
                          ),
                    
                          Card(shadowColor: Colors.white,
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              height: 38,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.payment_rounded,color:  Color.fromARGB(255, 69, 109, 145),),
                                    SizedBox(width: 50,),
                                    Text("Payment details"),
                                
                                  ],
                                ),
                              )
                           
                            ),
                          ),
                         
                          Card(shadowColor: Colors.white,
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              height: 38, 
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.history,color:  Color.fromARGB(255, 69, 109, 145),),
                                    SizedBox(width: 50,),
                                    Text("Order history"),
                                
                                  ],
                                ),
                              )
                           
                            ),
                          ),
                          Card(shadowColor: Colors.white,
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              height: 38, 
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.card_giftcard,color:  Color.fromARGB(255, 69, 109, 145),),
                                    SizedBox(width: 50,),
                                    Text("Rewards"),
                                
                                  ],
                                ),
                              )
                           
                            ),
                          ),
                          Card(shadowColor: Colors.white,
                            color: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SizedBox(
                              height: 38,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Icon(Icons.discount,color:  Color.fromARGB(255, 69, 109, 145),),
                                    SizedBox(width: 50,),
                                    Text("Student discount"),
                                
                                  ],
                                ),
                              )
                           
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                        "Notifications",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
              ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:  Colors.grey.shade50,
                        ),
                        width: screenWidth * 0.87,
                        height: 130,
                        child: Column(
                          children: [
                            Card(shadowColor: Colors.white,
                              color: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SizedBox(
                                height: 38, 
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.notifications,color: const Color.fromARGB(255, 69, 109, 145),),
                                      SizedBox(width: 40,),
                                      Text("Recieve notification"),
                                      SizedBox(width: 32,),
                                     Obx(() =>  Transform.scale(
                                      scale: 0.7,
                                       child: Switch(
                                        value: switchController.isSwitched1.value, onChanged: (value) {
                                          switchController.toggleSwitch1(value);
                                        },),
                                     ),),
                                  
                                    ],
                                  ),
                                )
                             
                              ),
                            ),
                      
                            Card(shadowColor: Colors.white,
                              color: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SizedBox(
                                height: 38,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_pin,color:  Color.fromARGB(255, 69, 109, 145),),
                                      SizedBox(width: 40,),
                                      Text("Share Location data"),
                                       SizedBox(width: 31,),
                                     Obx(() =>  Transform.scale(
                                      scale: 0.7,
                                       child: Switch(
                                        value: switchController.isSwitched2.value, onChanged: (value) {
                                          switchController.toggleSwitch2(value);
                                        },),
                                     ),),
                                  
                                    ],
                                  ),
                                )
                             
                              ),
                            ),
                            
                           
                            
                                ],
                              ),
                            ),
                    ),
                   Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                        "Other",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      ),
              ),
              SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color:  Colors.grey.shade50,
                        ),
                        width: screenWidth * 0.87,
                        height: 138,
                        child: Column(
                          children: [
                            Card(shadowColor: Colors.white,
                              color: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SizedBox(
                                height: 38, 
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_pin,color: const Color.fromARGB(255, 69, 109, 145),),
                                      SizedBox(width: 50,),
                                      Text("Location"),
                                      SizedBox(width: 50,),
                                     
                                  
                                    ],
                                  ),
                                )
                             
                              ),
                            ),
                      
                            Card(shadowColor: Colors.white,
                              color: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SizedBox(
                                height: 38,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      Icon(Icons.attach_money,color:  Color.fromARGB(255, 69, 109, 145),),
                                      SizedBox(width: 50,),
                                      Text("Currency"),
                                       SizedBox(width: 50,),
                                 ],
                                  ),
                                )
                             
                              ),
                            ),
                            GestureDetector(
  onTap: () {
    
   UserSession().logout(context);
  },
  child: Card(
    shadowColor: Colors.white,
    color: Colors.grey.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: SizedBox(
      height: 38,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Icon(Icons.logout, color: Color.fromARGB(255, 69, 109, 145)),
            SizedBox(width: 50),
            Text("Logout"),
            SizedBox(width: 50),
          ],
        ),
      ),
    ),
  ),
),

                            
                                ],
                              ),
                            ),
                    ),
              ]
              ),
        )
    )
    );
  }
}
