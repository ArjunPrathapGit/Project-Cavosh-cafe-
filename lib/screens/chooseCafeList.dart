import 'package:coffee/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CafeList extends StatefulWidget {
  CafeList({super.key});

  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  
  final List<String> coffeeImages = [
    "assets/images/shopName.png",
    "assets/images/shopName.png",
    "assets/images/shopName.png",
    "assets/images/shopName.png",
    "assets/images/shopName.png",
  ];
  
  final List<String> cafeNames = [
    "Cavosh Cafe1",
    "Cavosh Cafe2",
    "Cavosh Cafe3",
    "Cavosh Cafe4",
    "Cavosh Cafe5",
  ];


 
  
  final List<String> coffeeRates = [
    "Open 8 am - 22pm",
    "Open 8 am - 22pm",
    "Open 8 am - 22pm",
    "Open 8 am - 22pm",
    "Open 8 am - 22pm",
  ];
  
  String? selectedTopValue; // For the top radio buttons
  String? selectedCafe; // For cafe selection
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
         backgroundColor:  Color.fromARGB(255,224,225, 221),
        body: Stack(
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
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.055),
              child: Row(
                children: [
                  GestureDetector(onTap: () {
                     Navigator.pop(context);
                  },
                    child: Icon(Icons.navigate_before)),
                  SizedBox(width: 50),
                  Text(
                    "Choose your Cafe",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 130, left: 16, right: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // RadioButtonExample(
                          //   selectedValue: selectedTopValue,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedTopValue = value; // Update the selected top radio button
                          //     });
                          //   },
                          // ),
                          // SizedBox(height: 8),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 9),
                          //   child: TextFormField(
                          //     controller: searchController,
                          //     decoration: InputDecoration(
                          //       enabledBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(20),
                          //         borderSide: BorderSide(color: Colors.white),
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(20),
                          //         borderSide: BorderSide(color: Colors.grey),
                          //       ),
                          //       hintText: "Search",
                          //       hintStyle: TextStyle(color: Colors.grey[500]),
                          //       filled: true,
                          //       fillColor: Colors.grey[200],
                          //       suffixIcon: IconButton(
                          //         icon: Icon(Icons.search, color: Colors.white, size: 37),
                          //         onPressed: () {
                          //           print("Searching for: ${searchController.text}");
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 16),
                          TabBar(
                            controller: _tabController,
                            tabs: [
                              Tab(text: "Cafes"),
                              Tab(text: "Map"),
                            ],
                          ),
                          Container(
                            height: 490, // Ensure this height is set for the TabBarView
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                ListView.builder(
                                  itemCount: coffeeImages.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // Navigate to Item page using Navigator
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
                                              height: 95,
                                              width: 93,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Image.asset(coffeeImages[index], fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    cafeNames[index],
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                                                  ),
                                                  Text(
                                                    coffeeRates[index],
                                                    style: TextStyle(
                                                      color: const Color.fromARGB(255, 48, 40, 39),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Radio<String>(
                                              value: cafeNames[index],
                                              groupValue: selectedCafe,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCafe = value; // Update the selected cafe
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Google Map widget
                                Container(
                                  height: 230, // Ensure this height is set for the map
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(25.200024645065195, 55.27418347847539),
                                      zoom: 14.0,
                                    ),
                                    markers: <Marker>{
                                      Marker(
                                        markerId: MarkerId("1"),
                                        position: LatLng(25.200024645065195, 55.27418347847539),
                                        infoWindow: InfoWindow(
                                          title: 'Marker Title',
                                          snippet: 'Marker Snippet',
                                        ),
                                      ),
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          // Display chosen cafe name
                          if (selectedCafe != null) 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chosen Cafe: $selectedCafe",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Buttons below chosen cafe
                if (selectedCafe != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     ElevatedButton(
        style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 52, 58, 96), // Button background color
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
        ),
        onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Cart(),));
      print("Saved: $selectedCafe");
        },
        child: Text(
      "Save",
      style: TextStyle(
        color: Colors.white, // Change this to your desired text color
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
        ),
      ),
      
      ElevatedButton(
        style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 52, 58, 96), // Button background color
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        onPressed: () {
      print("Cancelled");
        },
        child: Text(
      "Cancel",
      style: TextStyle(
        color: Colors.white, // Change this to your desired text color
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
        ),
      ),
      
      
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}

class RadioButtonExample extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const RadioButtonExample({
    Key? key,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Frequently Chosen'),
            trailing: Radio<String>(
              value: 'Frequently Chosen',
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
          ),
          ListTile(
            title: Text('Search by city'),
            trailing: Radio<String>(
              value: 'Search by city',
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
