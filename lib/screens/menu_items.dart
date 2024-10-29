
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Item extends StatefulWidget {
  final String img;
  final String itemNames;
  final String price;
  final String username;

  const Item({
    Key? key,
    required this.img,
    required this.itemNames,
    required this.price,
    required this.username,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int quantity = 1;
   bool isFavorited = false;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  Future<void> addToCart() async {
    try {
      // Prepare the item details to be added to the Firestore
      Map<String, dynamic> item = {
        'itemName': widget.itemNames.isNotEmpty ? widget.itemNames : 'Unnamed Item',
        'img': widget.img.isNotEmpty ? widget.img : 'assets/default_image.png',
        'price': double.tryParse(widget.price.replaceAll('\$', '') ?? '0') ?? 0,
        'quantity': quantity,
      };

      // Add item to Firestore under the user's cart collection
      await FirebaseFirestore.instance
          .collection('Profiles') // Adjust according to your Firestore structure
          .doc(widget.username) // Using username as the document ID
          .collection('Cart') // Subcollection for cart items
          .add(item);

      print("Added to cart: $item for user: ${widget.username}");
      showToast('Item added to cart!');
    } catch (e) {
      print("Failed to add to cart: $e");
      showToast('Failed to add item to cart: $e');
    }
  }
   Future<void> toggleFavorite() async {
    setState(() {
      isFavorited = !isFavorited; // Toggle favorite state
    });

    if (isFavorited) {
      // Add item to favorites
      await FirebaseFirestore.instance
          .collection('Profiles')
          .doc(widget.username)
          .collection('Favorites')
          .add({
            'itemName': widget.itemNames,
            'img': widget.img,
            'price': double.tryParse(widget.price.replaceAll('\$', '') ?? '0') ?? 0,
          });
      showToast('Item added to favorites!');
    } else {
      // Remove item from favorites
      var favoritesCollection = FirebaseFirestore.instance
          .collection('Profiles')
          .doc(widget.username)
          .collection('Favorites');

      // Here you would need a way to find the specific favorite item to delete
      // For example, you might need to store the document ID when adding to favorites
      // Assuming you can find it by itemName or img for demonstration:
      QuerySnapshot snapshot = await favoritesCollection
          .where('itemName', isEqualTo: widget.itemNames)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await favoritesCollection.doc(snapshot.docs.first.id).delete();
        showToast('Item removed from favorites!');
      }
    }
  }
  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    checkIfFavorited();
  });
}

 
  Future<void> checkIfFavorited() async {     // stay favourited
  var favoritesCollection = FirebaseFirestore.instance
      .collection('Profiles')
      .doc(widget.username)
      .collection('Favorites');

  QuerySnapshot snapshot = await favoritesCollection
      .where('itemName', isEqualTo: widget.itemNames)
      .get();

  if (snapshot.docs.isNotEmpty) {
    setState(() {
      isFavorited = true;
    });
  }
}


  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double itemPrice = double.tryParse(widget.price.replaceAll('\$', '') ?? '0') ?? 0;
    double totalPrice = itemPrice * quantity; // Calculate total price

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 225, 221),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: GestureDetector(
                    child: const Icon(Icons.navigate_before),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: GestureDetector(
                    onTap:toggleFavorite,
                    // Favorite button functionality here
                    child:  Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.red : Colors.black, // Change color based on favorite state
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 270,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    widget.img.isNotEmpty ? widget.img : 'assets/default_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text(
                        widget.itemNames.isNotEmpty ? widget.itemNames : 'Unnamed Item',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: 80,
                        height: 35,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.grey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: decrement,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                              child: Text(
                                '$quantity',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: increment,
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Size",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Placeholder for your actual CustomRadioButton widget
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Customise your Coffee",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // Placeholder for your actual CustomCheckboxes widget
                const SizedBox(height: 20),
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text("Total price"),
                          // Display the calculated total price
                          Text('\$${totalPrice.toStringAsFixed(2)}'), // Format to 2 decimal places
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addToCart();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 60, 47, 41),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Add to cart",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
