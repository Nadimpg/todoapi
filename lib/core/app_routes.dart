

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:todo_app/view/screens/todo/todo_screen.dart';

class AppRoutes{
  static String todoScreen = "/todo_screen";

  static List<GetPage> routes =[
    GetPage(name: todoScreen, page: ()=> const TodoScreen()),
  ];
}