import 'package:get/get.dart';

class ItemController extends GetxController {
  // Assuming you already have these properties
  var isFavorite = false.obs;
  var counter = 1.obs; // Starting quantity of the item
  var selectedSize = ''.obs; // Size selected by the user
  var selectedOptions = <String>[].obs; // Options selected by the user
  var options = ['Extra Shot', 'Oat Milk', 'Whipped Cream'].obs; // Example options

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void increment() {
    counter.value++;
  }

  void decrement() {
    if (counter.value > 1) { // Prevent decrementing below 1
      counter.value--;
    }
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void toggleOption(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }

  // Method to add item to cart
  void addToCart({
    required String itemName,
    required String price,
    required int quantity,
    required String img,
  }) {
    // Implement your logic to add to cart
    // For example, you can store it in a list or a Firestore database
    print('Adding to cart: $itemName, Price: $price, Quantity: $quantity, Image: $img');

    // Here you would add the logic to save the item to your cart
  }
}
