import 'package:CheckBox/firebase_options.dart';
import 'package:CheckBox/routes/app_pages.dart';
import 'package:CheckBox/routes/routes.dart';
import 'package:CheckBox/src/controller/controller.dart';
import 'package:CheckBox/src/models/models.dart';
import 'package:CheckBox/src/utils/login_cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(WelcomeScreenController());
  UserController userController = Get.put(UserController());
  Get.put(TodoController());

  UserModel? savedUser = await LoginCache.getUserData();
  userController.saveUserData(savedUser);
  userController.checkCachedLogin();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.welcome,
      getPages: AppPages.pages,
      transitionDuration: Duration(milliseconds: 100),
    );
  }
}
