import 'package:get/get.dart';

class ItemController extends GetxController {
  var counter = 0.obs;
  var isFavorite = false.obs;
  var selectedSize = 'Small'.obs;
  var options = ['Milk', 'Cream', 'Coffee'];
  var selectedOptions = <String>[].obs;

  void increment() => counter++;
  void decrement() {
    if (counter > 0) counter--;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
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
}
