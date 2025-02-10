import 'package:get/get.dart';
import 'package:diet_app_mobile/controller/basic/meal/meal_add_controller.dart';

class MealAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealAddController>(() => MealAddController());
  }
} 