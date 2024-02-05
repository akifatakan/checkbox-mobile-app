import 'package:CheckBox/routes/routes.dart';
import 'package:CheckBox/src/screens/screens.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.home, page: () => HomeScreen()),
    GetPage(name: Routes.signIn, page: () => SignInScreen()),
    GetPage(name: Routes.signUp, page: () => SignUpScreen()),
    GetPage(name: Routes.welcome, page: () => WelcomeScreen()),
    GetPage(name: Routes.createTodo, page: () => CreateTodoScreen()),
    GetPage(name: Routes.completedTodos, page: () => CompletedTodosScreen()),
    GetPage(name: Routes.overdueTodos, page: () => OverdueTodosScreen()),
  ];
}
