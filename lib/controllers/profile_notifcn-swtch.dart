import 'package:get/get.dart';

class SwitchController extends GetxController {
  var isSwitched1 = false.obs; // First switch
  var isSwitched2 = false.obs; // Second switch

  void toggleSwitch1(bool value) {
    isSwitched1.value = value;
  }

  void toggleSwitch2(bool value) {
    isSwitched2.value = value;
  }
}

