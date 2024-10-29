

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/screens/login.dart';
// import 'package:coffee/viewmodel/displaymsgToUser.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
class _RegisterState extends State<Register> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();
  TextEditingController confirmPassController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

void _validateAndSubmit() {
  // Dismiss the keyboard
  FocusScope.of(context).unfocus();

  if (_formKey.currentState!.validate()) {
    // Proceed with registration logic
    registerUser(emailController.text, passController.text, fullNameController.text);
  }
}




  Future<void> registerUser(String email, String password, String username) async {
    // Show loading circle
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Create a reference to Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Check if the email already exists
    QuerySnapshot emailSnapshot = await firestore
        .collection("Profiles")
        .where("Email", isEqualTo: email)
        .get();

    if (emailSnapshot.docs.isNotEmpty) {
      // Email already exists
      Navigator.pop(context); // Close loading circle
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is already registered"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
      return;
    }

    // Check if the username already exists
    QuerySnapshot usernameSnapshot = await firestore
        .collection("Profiles")
        .where("Username", isEqualTo: username)
        .get();

    if (usernameSnapshot.docs.isNotEmpty) {
      // Username already exists
      Navigator.pop(context); // Close loading circle
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This name is already taken"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
      return;
    }

    // Create a user document in the 'Profiles' collection
    DocumentReference userDoc = firestore.collection("Profiles").doc(username);

    // Set user data
    await userDoc.set({
      "Username": username,
      "Password": password,
      "Email": email,
    });
    // Create a 'Cart' collection inside the user's document
  // CollectionReference cartCollection = userDoc.collection("Cart");

  // // You can initialize it with some data if needed
  // await cartCollection.add({
  //   // Example data
  //   "cartItem": [],
  // });

    // Pop loading circle
    Navigator.pop(context);

    // Navigate to login page after successful registration
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );
  }


  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
                          
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              
                            ),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color.fromARGB(255, 13, 27,42),
                            padding: EdgeInsets.symmetric(vertical: 16,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
                  key: _formKey, 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 88)),
                      TextFormField(validator: (value) {
      if (value!.isEmpty) {
    return "Username is required";
      }
      return null;
    },
    
                        
                                  
                                  controller: fullNameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    hintText: "User Name",
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    filled: true,
                                    fillColor: Colors.grey[300],
                                  ),
                                ),
                                SizedBox(height: 13),
                      TextFormField(
                                  validator: (value) {
      if (value!.isEmpty) {
    return "Email is required";
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return "Enter a valid email";
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
                                SizedBox(height: 13),
                                TextFormField(
                                  validator: (value) {
      if (value!.isEmpty) {
    return "Password is required";
      } else if (value.length < 6) {
    return "Password should be at least 6 characters";
      }
      return null;
    },
    
                    controller: passController,
                    obscureText: _obscureText,
                   
    
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
                  SizedBox(height: 13),
                                TextFormField(
                    controller: confirmPassController,
                    obscureText: _obscureText,
                    validator: (value) {
      if (value!.isEmpty) {
    return "Confirm Password is required";
      } else if (value != passController.text) {
    return "Passwords do not match";
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
                      hintText: "Confirm Password",
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
                  SizedBox(height: 7,),
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
                              SizedBox(height: 9,),
                              ElevatedButton(
                          onPressed:_validateAndSubmit,
                          style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 13, 27,42),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          // side: BorderSide(color:  Color.fromARGB(250, 107, 62, 46), width: 2), // Add border here
                        ),
                          ),
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 110),
                        child: Text(
                          "Register",
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
                              SizedBox(height: 14),
                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already a member?   ", style: TextStyle(color: Colors.grey.shade700)),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => Login()),
                                      );
                                    },
                                    child: Text("Login now",
                                        style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
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
