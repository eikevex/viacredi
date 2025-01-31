import 'package:get/get.dart';

class RatingController extends GetxController {
  var environmentRating = Rx<int>(0);
  var serviceRating = Rx<int>(0);
  var timeRating = Rx<int>(0);

  void updateEnvironmentRating(int rating) {
    if (rating == 0) rating = 1;
    environmentRating.value = rating;
  }

  void updateServiceRating(int rating) {
    if (rating == 0) rating = 1;
    serviceRating.value = rating;
  }

  void updateTimeRating(int rating) {
    if (rating == 0) rating = 1;
    timeRating.value = rating;
  }
}
    final RatingController controllerRank = Get.put(RatingController());