import 'package:get/get.dart';

class IndicationController extends GetxController {
  var rating = Rx<int?>(null);

  void updateRating(int? newRating) {
    rating.value = newRating;
  }
}

final IndicationController controllerRating = Get.put(IndicationController());
