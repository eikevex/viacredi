import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/controllers/ratingController.dart';
import 'package:viacredi/pages/cpfquestion.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/utils/timer.dart';
import 'package:viacredi/widgets/background.dart';
import 'package:viacredi/widgets/sendButton.dart';
import 'package:viacredi/widgets/star_rating.dart';

class Satisfaction extends StatefulWidget {
  const Satisfaction({super.key});

  @override
  State<Satisfaction> createState() => _SatisfactionState();
}

class _SatisfactionState extends State<Satisfaction> {
  final FormDataController controller = Get.find();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimerProvider>(context, listen: false).resetTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    if (timerProvider.secondsRemaining == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Get.off(() => Indication());
          controllerRank.environmentRating.value = 0;
          controllerRank.serviceRating.value = 0;
          controllerRank.timeRating.value = 0;
        }
      });
    }

    return GestureDetector(
      onTap: timerProvider.resetTimer,
      child: Background(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ambiente do Posto de Atendimento ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(() => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StarRating(
                                  rating:
                                      controllerRank.environmentRating.value,
                                  onRatingChanged: (rating) => controllerRank
                                      .updateEnvironmentRating(rating),
                                  timerProvider: timerProvider,
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 15),
                    Text(
                      'Atendimento dos Colaboradores',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(() => Column(
                          children: [
                            StarRating(
                              rating: controllerRank.serviceRating.value,
                              onRatingChanged: (rating) =>
                                  controllerRank.updateServiceRating(rating),
                              timerProvider: timerProvider,
                            ),
                          ],
                        )),
                    SizedBox(height: 15),
                    Text(
                      'Tempo de Espera',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Obx(() => Column(
                          children: [
                            StarRating(
                              rating: controllerRank.timeRating.value,
                              onRatingChanged: (rating) =>
                                  controllerRank.updateTimeRating(rating),
                              timerProvider: timerProvider,
                            ),
                          ],
                        )),
                    SizedBox(height: 30),
                    SendButton(
                      onPressed: () {
                        if (controllerRank.environmentRating.value == 0 ||
                            controllerRank.serviceRating.value == 0 ||
                            controllerRank.timeRating.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Por favor, avalie todos os itens antes de continuar.',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          controller.updateData(
                            environment: controllerRank.environmentRating.value,
                            service: controllerRank.serviceRating.value,
                            waitingTime: controllerRank.timeRating.value,
                          );
                          controllerRank.environmentRating.value = 0;
                          controllerRank.serviceRating.value = 0;
                          controllerRank.timeRating.value = 0;
                          Get.to(() => CpfQuestion());
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
