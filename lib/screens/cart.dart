
import 'package:coffee/screens/deliveryMethod.dart';
import 'package:coffee/screens/userSession.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';


// ignore: must_be_immutable
class Cart extends StatelessWidget {
  final String? username;
  String? currentusername = UserSession().getUsername();
   Cart({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      body: Column(
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
              Positioned(
                left: 20,
                top: 40,
                child: const Text(
                  'Your Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Spacing below the image
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Profiles')
                  .doc(currentusername)
                  .collection('Cart')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('Your cart is empty.'));
                }

                final items = snapshot.data!.docs;

                // Calculate total price
                double totalPrice = 0;
                for (var item in items) {
                  totalPrice += (item['price'] ?? 0) * (item['quantity'] ?? 1);
                }

                return Column(
                  children: [
                    Expanded(
                      child: Expanded(
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      final itemName = item['itemName'] ?? 'Unnamed Item';
      final img = item['img'] ?? 'assets/default_image.png';
      final price = item['price'] ?? 0;
      final quantity = item['quantity'] ?? 1;

      return Card(
        elevation: 5, // Add shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // More padding for comfort
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12), // Rounded image corners
                child: Image.asset(
                  img,
                  width: 80, // Slightly larger image size
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15), // Space between image and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(
                        fontSize: 18, // Larger font size for better readability
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4), // Space between text elements
                    Text(
                      'Price: \$${price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4), // Space between text elements
                    Text(
                      'Quantity: $quantity',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteItem(item.id); // Call delete function
                },
              ),
            ],
          ),
        ),
      );
    },
  ),
),

                    ),
                    // Total Price Display
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 27, 38, 59),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Price:',
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              
                            ],
                          ),
                          const SizedBox(height: 16), // Spacing between total price and button
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {print("$currentusername passed");
                                  _checkout(context); // Call checkout function
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 36, 161, 80), // Button color
                                  padding: const EdgeInsets.symmetric(horizontal: 20, ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Checkout',
                                      style: TextStyle(fontSize: 16,color: Colors.white),
                                    ),
                                    IconButton(onPressed: () {
                                      
                                    }, icon: Icon(Icons.shopping_bag_sharp,color: Colors.white,))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to delete an item from Firestore
  void _deleteItem(String itemId) {
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(currentusername) // Ensure this is the correct user document
        .collection('Cart')
        .doc(itemId) // Use the document ID to delete
        .delete()
        .then((_) {
          // Optionally show a toast or snackbar confirming deletion
          print("Item deleted successfully");
        }).catchError((error) {
          // Handle error
          print("Failed to delete item: $error");
        });
  }

  // Function to handle checkout


void _checkout(BuildContext context) {
  // Show a toast message immediately
  // Fluttertoast.showToast(
  //   msg: "Proceeding to checkout...",
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.BOTTOM, // You can customize the position
  //   backgroundColor: Colors.black54,
  //   textColor: Colors.white,
  //   fontSize: 16.0,
  // );

  // Navigate to the delivery method screen
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Deliverymethod(username: currentusername ?? "User"),
    ),
  );
}

  
}
