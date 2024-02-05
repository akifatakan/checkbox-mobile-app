import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs; // Reactive variable for the current index

  setCurrentIndex(int index){
    currentIndex.value = index;
  }
}
