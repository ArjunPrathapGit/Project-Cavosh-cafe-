import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/screens/home.dart';
import 'package:coffee/screens/register.dart';
import 'package:coffee/screens/userSession.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Login extends StatefulWidget {
  
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final formkey = GlobalKey<FormState>();

 

 void _login() async {
  if (formkey.currentState!.validate()) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      String email = emailController.text.trim();
      String password = passController.text.trim();

      QuerySnapshot userSnapshot = await firestore
          .collection("Profiles")
          .where("Email", isEqualTo: email)
          .where("Password", isEqualTo: password)
          .get();

      Navigator.pop(context);

      // Debugging: Print the retrieved documents
      print('User Snapshot: ${userSnapshot.docs.map((doc) => doc.data()).toList()}');

      if (userSnapshot.docs.isNotEmpty) {
        String userName = userSnapshot.docs.first['Username'] ?? 'Unknown User'; // Provide a default if null
        
        // Set the username in UserSession
        UserSession().setUsername(userName);
        

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home(userName: userName)),
          (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid email or password"),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $e"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
    }
  }
}


  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
void dispose() {
  emailController.dispose();
  passController.dispose();
  _userNameFocusNode.dispose(); // Dispose the FocusNode
  _passFocusNode.dispose(); // Dispose the FocusNode
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         resizeToAvoidBottomInset: false,
        body: Container(
          color: Color.fromARGB(255,224,225, 221),
          height: double.infinity,
          width: double.infinity,
          child: Stack(
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
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  Color.fromARGB(255, 13, 27,42),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register(),));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formkey,
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 45)),
                      TextFormField(focusNode: _userNameFocusNode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is required";
                                    }
                                    return null;
                                  },
                                  controller: emailController,

                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                  ),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  focusNode: _passFocusNode,
                    controller: passController,
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: " Password",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[300],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 26),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(child: Text("Forgot Password?",style: TextStyle(color: Colors.brown.shade700),)
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18,),
                              ElevatedButton(
                          onPressed:_login,
                          style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 13, 27,42),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // side: BorderSide(color: Color.fromARGB(250, 107, 62, 46), width: 2), // Add border here
                        ),
                          ),
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                          ),
                        ),
                               Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
                                    Center(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("Or Login with"),
                                    )),
                                    Expanded(child: Divider(thickness: 0.5, color: Colors.grey)),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset("assets/images/google_logo.png",height: 24,width: 27,),
                                  ),
                                   Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset("assets/images/apple_logo.png",height: 24,width: 27),
                                  ),
                                   Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset("assets/images/facebook_logo.png",height: 24,width: 27),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Not a member?   ", style: TextStyle(color: Colors.grey.shade700)),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => Register()),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text("Register now",
                                          style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                    ],
                  ),
                ),
              )
            ],
          ),
          
        ),
        
      ),
    );
  }
}