import 'package:coffee/screens/menu_items.dart';
import 'package:coffee/screens/userSession.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Menu extends StatefulWidget {
   final String? userName;
   String? currentusername = UserSession().getUsername();
  Menu({super.key,this.userName});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {  
  final TextEditingController searchController = TextEditingController();
  
  final List<String> categories = [
    "Hot Drinks",
    "Cold Drinks",
    "Juice",
    "Smoothies",
  ];

  final Map<String, List<String>> categoryItems = {
    "Hot Drinks": [
      "Hot chocolate",
      "Hot tea",
      "Ginger tea",
      "Honey milk",
    ],
    "Cold Drinks": [
      "Iced espresso",
      "Cold brew",
      "Iced macchiato",
      "Iced mocha",
    ],
    "Juice": [
      "Apple juice",
      "Blueberry ",
      "Cranberry ",
      "Grapefruit ",
    ],
    "Smoothies": [
      "Peanut Butter",
      "Tropical Oat",
      "Strawberry",
      "Cherry",
    ],
  };

  final Map<String, List<String>> categoryImages = {
    "Hot Drinks": [
      "assets/images/hot-chocolate-recipe4.jpg",
      "assets/images/hot-tea.webp",
      "assets/images/ginger-tea.webp",
      "assets/images/honey-milk.jpg",
    ],
    "Cold Drinks": [
      "assets/images/Iced espresso.jpg",
      "assets/images/cold-brew.jpg",
      "assets/images/Iced macchiato.jpg",
      "assets/images/Iced mocha.jpg",
    ],
    "Juice": [
      "assets/images/Apple juice.webp",
      "assets/images/Blueberry Juice.jpg",
      "assets/images/Cranberry Juice.jpg",
      "assets/images/Grapefruit Juice.jpg",
    ],
    "Smoothies": [
      "assets/images/Peanut Butter Smoothie Bowl.jpg",
      "assets/images/Tropical Oatmeal Smoothie.webp",
      "assets/images/Strawberry-Green Tea Smoothie.webp",
      "assets/images/Cherry-Almond Smoothie.webp",
    ],
  };

  final Map<String, List<String>> categoryRates = {
    "Hot Drinks": ["\$4", "\$3", "\$5", "\$3"],
    "Cold Drinks": ["\$3", "\$2", "\$4", "\$3"],
    "Juice": ["\$1", "\$2", "\$3", "\$2"],
    "Smoothies": ["\$5", "\$3", "\$4", "\$3"],
  };

  int selectedCategoryIndex = 0; 
  List<String> selectedItems = [];
  List<String> selectedImages = [];
  List<String> selectedRates = [];

  @override
  void initState() {
    super.initState();
    _updateSelectedCategory(selectedCategoryIndex);
  }

  void _onCategoryTap(int index) {
    setState(() {
      selectedCategoryIndex = index;
      _updateSelectedCategory(index);
    });
  }

  void _updateSelectedCategory(int index) {
    selectedItems = categoryItems[categories[index]]!;
    selectedImages = categoryImages[categories[index]]!;
    selectedRates = categoryRates[categories[index]]!;
  }

  
  void _onItemTap(String itemName, String imageName, String price) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Item(
        itemNames: itemName,
        img: imageName,
        price: price, username: widget.currentusername ?? "User",
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      
      child: Scaffold(
        backgroundColor:  Color.fromARGB(255,224,225, 221),
        body: Stack(
          children: [
            // Background image
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
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(
                      color: Color.fromARGB(255, 247, 240, 208),
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
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
              padding: EdgeInsets.only(top: screenHeight * 0.26),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12),
                      child: Row(
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _onCategoryTap(index),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                color: selectedCategoryIndex == index ?const Color.fromARGB(255, 27, 38, 59): Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                categories[index],
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                      
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: selectedItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _onItemTap(selectedItems[index],
                                selectedImages[index],
                                selectedRates[index]), // Handle item tap
                              child: Container(
                                height: 250,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      height: 109,
                                      width: 118,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          selectedImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      selectedItems[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      selectedRates[index],
                                      style: TextStyle(color: const Color.fromARGB(255, 225, 139, 133), fontWeight: FontWeight.bold),
                                    ),
                                    
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}