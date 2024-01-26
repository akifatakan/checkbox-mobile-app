import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import '../services/services.dart';

class UserController extends GetxController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseUserServices _userServices = FirebaseUserServices();
  var isUserSignedIn = false.obs; // Reactive state
  Rx<UserModel?> user = Rx<UserModel?>(null); // Make 'user' reactive if needed

  Future<void> signInWithCredentials(String email, String password) async {
    User? _user =
        await _authService.signInWithEmailAndPassword(email, password);
    if (_user != null) {
      isUserSignedIn.value = true;
      // Fetch user details and set them to 'user' observable
      user.value = await _userServices.getUserById(_user.uid);
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
      isUserSignedIn.value = true;
      user.value = newUser; // Set the created user to the 'user' observable
    } else {
      isUserSignedIn.value = false;
      print('Error occurred');
    }
  }

  void signOut() async {
    await _authService.signOut();
    isUserSignedIn.value = false;
    user.value = null;
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
      isUserSignedIn.value = true;
      user.value = newUser;
    } else {
      isUserSignedIn.value = false;
      print('Error occurred');
    }
  }
}
