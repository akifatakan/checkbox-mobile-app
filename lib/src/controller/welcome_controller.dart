import 'dart:async';

import 'package:get/get.dart';

import '../../routes/routes.dart';

class WelcomeScreenController extends GetxController {
  var progressValue = 0.0.obs;
  Timer? _timer;

  void startTimer() {
    progressValue.value = 0.0; // Reset progress value to 0
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      if (progressValue.value < 1.0) {
        progressValue.value += 0.01;
      } else {
        timer.cancel();
        Get.offNamed(Routes.home);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when controller is disposed
    super.onClose();
  }
}
