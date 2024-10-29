import 'package:coffee/screens/home.dart';
import 'package:get/get.dart';

class NavigationControllerforhome extends GetxController {
  // Function to navigate to Home
  void goToHome() {
    Get.offAll(Home()); // Use Get.offAll to clear the previous routes
  }
}
