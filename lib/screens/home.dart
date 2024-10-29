import 'package:coffee/controllers/getxControllers.dart';
import 'package:coffee/screens/cart.dart';
import 'package:coffee/screens/favourite.dart';
import 'package:coffee/screens/menu.dart';
import 'package:coffee/screens/menu_items.dart';
import 'package:coffee/screens/profile.dart';
import 'package:coffee/screens/userSession.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
    final String? userName;
    String? currentusername = UserSession().getUsername();
    Home({Key? key,  this.userName}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  final NavigationController navcontroller = Get.put(NavigationController());

  final List<String> coffeeImages = [
    "assets/images/CaramelMacchiato.jpg",
    "assets/images/vannila_latte.jpg",
    "assets/images/white_chocholate_mocha.jpg",
    "assets/images/Traditional-Cappuccino.png",
    "assets/images/americano_coffee.jpg",
  ];
  final List<String> coffeeNames = [
    "Caramel\nMacchiato",
    "Vanilla\nLatte",
    "White\nChocolate",
    "Traditional\nCappuccino",
    "Americano\nCoffee"
  ];
  final List<String> coffeeRates = [
    "\$4",
    "\$3",
    "\$5",
    "\$3",
    "\$4",
  ];

  // Variables for back button confirmation
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (_lastPressedAt == null || now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = now;
          // Show a message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Press again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent exiting
        }
        return true; // Allow exiting
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 224, 225, 221),
          body: Obx(() {
            switch (navcontroller.selectedIndex.value) {
              case 0:
                return buildHomeContent(screenHeight, screenWidth);
              case 1:
                return Menu(userName: widget.userName,);
              case 2:
                return FavoritesScreen();
              case 3:
                return Cart(username:widget.userName ,);
              case 4:
                return Profile();
              default:
                return buildHomeContent(screenHeight, screenWidth);
            }
          }),
          bottomNavigationBar: Obx(() {
            return BottomNavigationBar(
              currentIndex: navcontroller.selectedIndex.value,
              onTap: (index) {
                navcontroller.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              ],
              backgroundColor: const Color.fromARGB(255, 77, 27, 16),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
            );
          }),
        ),
      ),
    );
  }

  Widget buildHomeContent(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
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
            padding: EdgeInsets.only(top: screenHeight * 0.04, left: screenWidth * 0.4),
            child: Text(
              "Cavosh",
              style: GoogleFonts.raleway(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                   'Good morning, ${widget.currentusername ?? "User"}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.notifications, color: Color.fromARGB(255, 247, 240, 208)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 135, horizontal: 21),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.grey[300],
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.white, size: 37),
                  onPressed: () {
                    print("Searching for: ${searchController.text}");
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.26, horizontal: screenWidth * 0.04),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "New in",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: coffeeImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Item page
                          Get.to(() => Item(
                            img: coffeeImages[index],
                            itemNames: coffeeNames[index],
                            price: coffeeRates[index], username:widget.currentusername ?? "User" ,
                          ));
                        },
                        child: Container(
                          width: 120,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                height: 90,
                                width: 93,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(coffeeImages[index], fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                coffeeNames[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 11),
                                    child: Text(
                                      coffeeRates[index],
                                      style: TextStyle(color: const Color.fromARGB(255, 44, 40, 40), fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 2),
                                    child: Icon(
                                      Icons.add,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Frequently ordered",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 21),
                Container(
                  height: 350,
                  child: ListView.builder(
                    itemCount: coffeeImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to Item page
                          Get.to(() => Item(
                            img: coffeeImages[index],
                            itemNames: coffeeNames[index],
                            price: coffeeRates[index],
                            username: widget.currentusername ?? "User", // Pass username
                          ));
                        },
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 97,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(coffeeImages[index], fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    coffeeNames[index],
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    coffeeRates[index],
                                    style: TextStyle(color: const Color.fromARGB(255, 44, 40, 40), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.add,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}

