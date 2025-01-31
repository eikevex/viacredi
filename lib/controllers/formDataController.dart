import 'package:get/get.dart';

class FormDataController extends GetxController {
  var indication = 0.obs;
  var environment = 0.obs;
  var service = 0.obs;
  var waitingTime = 0.obs;
  var cpf = ''.obs;
  var comment = ''.obs;

  void updateData({
    int? indication,
    int? environment,
    int? service,
    int? waitingTime,
    String? cpf,
    String? comment,
  }) {
    this.indication.value = indication ?? this.indication.value;
    this.environment.value = environment ?? this.environment.value;
    this.service.value = service ?? this.service.value;
    this.waitingTime.value = waitingTime ?? this.waitingTime.value;
    this.cpf.value = cpf ?? this.cpf.value;
    this.comment.value = comment ?? this.comment.value;
  }

  void clearData() {
    indication.value = 0;
    environment.value = 0;
    service.value = 0;
    waitingTime.value = 0;
    cpf.value = '';
    comment.value = '';
  }
}