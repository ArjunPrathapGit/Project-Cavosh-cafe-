import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/screens/order_tracking.dart';
import 'package:coffee/screens/userSession.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewOrder extends StatelessWidget {
  final String selectedPayment;
  final String selectedCard;
  final String address;
  final String selectedTime;
  final String selectedDate;
  final String username; // User ID to fetch the correct cart data
  String? currentusername = UserSession().getUsername();

   ReviewOrder({
    super.key,
    required this.selectedPayment,
    required this.selectedCard,
    required this.address,
    required this.selectedTime,
    required this.selectedDate,
    required this.username, // Pass userId from previous screen
  });

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 37),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.navigate_before),
                        ),
                        SizedBox(width: 60),
                        Text(
                          "Review Order",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Details", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    // StreamBuilder to fetch cart items
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Profiles')
                          .doc(username)
                          .collection('Cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        double subtotal = 0.0; // Declare subtotal here

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('No items in the cart'));
                        }

                        final cartItems = snapshot.data!.docs;

                        // Calculate subtotal
                        for (var item in cartItems) {
                          final data = item.data() as Map<String, dynamic>;
                          final itemQuantity = data['quantity']?.toString() ?? '0';
                          final itemPrice = data['price']?.toString() ?? '0.00';
                          subtotal += double.parse(itemPrice) * int.parse(itemQuantity);
                        }

                        return Column(
                          children: [
                            Container(
                              height: 140, // Set a fixed height for the cart items container
                              child: ListView.builder(
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  final data = cartItems[index].data() as Map<String, dynamic>;

                                  // Add null checks for the fields
                                  final itemName = data['itemName'] ?? 'Unknown Item';
                                  final itemQuantity = data['quantity']?.toString() ?? '0';
                                  final itemPrice = data['price']?.toString() ?? '0.00';

                                  return Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 237, 238, 239),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    height: 60,
                                    width: double.infinity,
                                    child: ListTile(
                                      title: Text(itemName, style: TextStyle(fontSize: 15)),
                                      subtitle: Text("Quantity: $itemQuantity", style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 44, 105, 155))),
                                      // Calculate total price based on item price and quantity
                                      trailing: Text("\$${(double.parse(itemPrice) * int.parse(itemQuantity)).toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    ),
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text("Deliver to", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 237, 238, 239),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text("Ernakulam", style: TextStyle(fontSize: 15)),
                                subtitle: Text(address, style: TextStyle(fontSize: 13, color: const Color.fromARGB(255, 44, 105, 155))),
                                trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit_calendar_sharp)),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text("Pickup Details", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 237, 238, 239),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text("Pickup time", style: TextStyle(fontSize: 15)),
                                        Spacer(),
                                        Text(selectedTime, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color.fromARGB(255, 44, 105, 155))),
                                      ],
                                    ),
                                    trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit_calendar_sharp)),
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text("Pickup date", style: TextStyle(fontSize: 15)),
                                        Spacer(),
                                        Text(selectedDate, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color.fromARGB(255, 44, 105, 155))),
                                      ],
                                    ),
                                    trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit_calendar_sharp)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Text("Payment", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 237, 238, 239),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(selectedPayment, style: TextStyle(fontSize: 15)),
                                    Spacer(),
                                    if (selectedPayment == "Card")
                                      Text(selectedCard, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color.fromARGB(255, 44, 105, 155)))
                                    else
                                      Text("", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: const Color.fromARGB(255, 44, 105, 155))),
                                  ],
                                ),
                                trailing: GestureDetector(onTap: () {}, child: Icon(Icons.edit_calendar_sharp)),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Subtotal"),
                                    Text("\$${subtotal.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                ElevatedButton(
                                  child: Text('Place order', style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                     clearCart();
                                    // Handle your navigation logic here
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderTracking(orderedTime:selectedTime ,location:address ,)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 55, 66, 75),
                                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void clearCart() {
    FirebaseFirestore.instance
        .collection('Profiles')
        .doc(currentusername)
        .collection('Cart')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    }).then((_) {
      print("Cart cleared successfully.");
    }).catchError((error) {
      print("Failed to clear cart: $error");
    });
  }
}
