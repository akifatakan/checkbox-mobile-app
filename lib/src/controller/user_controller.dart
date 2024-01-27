import 'package:CheckBox/src/utils/login_cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import '../services/services.dart';
import 'controller.dart';

class UserController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseUserServices _userServices = FirebaseUserServices();

  final WelcomeScreenController _welcomeController =
      Get.find<WelcomeScreenController>();

  var isUserSignedIn = false.obs; // Reactive state
  Rx<UserModel?> user = Rx<UserModel?>(null); // Make 'user' reactive if needed

  Future<void> signInWithCredentials(String email, String password) async {
    User? _user =
        await _authService.signInWithEmailAndPassword(email, password);
    if (_user != null) {
      isUserSignedIn.value = true;
      // Fetch user details and set them to 'user' observable
      user.value = await _userServices.getUserById(_user.uid);
      _welcomeController.startTimer();
      await LoginCache.saveUserData(user.value!);
    } else {
      isUserSignedIn.value = false;
    }
  }

  Future<void> signUpWithCredentials(String email, String password,
      String username, String displayName) async {
    User? _user =
        await _authService.signUpWithEmailAndPassword(email, password);
    if (_user != null) {
      UserModel newUser = UserModel(
        id: _user.uid,
        email: email,
        username: username,
        displayName: displayName,
      );
      await _userServices.createUser(newUser);
      _welcomeController.startTimer();
      isUserSignedIn.value = true;
      user.value = newUser; // Set the created user to the 'user' observable
      await LoginCache.saveUserData(user.value!);
    } else {
      isUserSignedIn.value = false;
      print('Error occurred');
    }
  }

  void signOut() async {
    await _authService.signOut();
    isUserSignedIn.value = false;
    user.value = null;
    await LoginCache.clearUserData();
  }

  Future<void> signInWithGoogle() async {
    User? _user = await _authService.signInWithGoogle();
    if (_user != null) {
      UserModel newUser = UserModel(
        id: _user.uid,
        email: _user.email!,
        username: _user.email!,
        displayName: _user.displayName!,
      );
      if (await _userServices.getUserById(_user.uid) == null) {
        await _userServices.createUser(newUser);
      }
      _welcomeController.startTimer();
      isUserSignedIn.value = true;
      user.value = newUser;
      await LoginCache.saveUserData(user.value!);
    } else {
      isUserSignedIn.value = false;
      print('Error occurred');
    }
  }

  void saveUserData(UserModel? userModel) {
    if (userModel != null) {
      isUserSignedIn.value = true;
    } else {
      isUserSignedIn.value = false;
    }
    user.value = userModel;
  }

  Future<void> checkCachedLogin() async {
    UserModel? cachedUser = await LoginCache.getUserData();
    if (cachedUser != null) {
      user.value = cachedUser;
      isUserSignedIn.value = true;
      _welcomeController.startTimer(); // Start the timer
    }
  }
}
