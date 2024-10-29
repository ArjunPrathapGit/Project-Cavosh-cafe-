import 'package:get/get.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <Map<String, dynamic>>[].obs; // Use a Map to hold item details

  // Example function to add items to the cart
  void addItem(String name, int quantity, double price) {
    cartItems.add({'name': name, 'quantity': quantity, 'price': price});
  }

  // Example function to remove an item
  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
