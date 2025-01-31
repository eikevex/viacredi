import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/services/firebase_service.dart';
import 'package:viacredi/utils/timer.dart';
import 'package:viacredi/widgets/background.dart';

class ThanksPage extends StatefulWidget {
  const ThanksPage({super.key});
  @override
  State<ThanksPage> createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  final FirebaseService _firebaseService = FirebaseService();
  final FormDataController controller = Get.find();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _sendData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimerProvider>(context, listen: false)
          .resetTimer(seconds: 10);
    });
  }

  Future<void> _sendData() async {
    await _firebaseService.sendData(
      indication: controller.indication.value,
      cpf: controller.cpf.value,
      comment: controller.comment.value,
      environment: controller.environment.value,
      service: controller.service.value,
      waitingTime: controller.waitingTime.value,
      userId: user!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    if (timerProvider.secondsRemaining == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Get.off(() => Indication());
        }
      });
    }

    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Obrigado!',
            style: TextStyle(
                fontSize: 100,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Seus dados foram enviados com '),
                TextSpan(
                  text: 'sucesso!',
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
