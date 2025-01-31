import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/controllers/indicationController.dart';
import 'package:viacredi/pages/satisfaction.dart';
import 'package:viacredi/utils/timer.dart';
import 'package:viacredi/widgets/background.dart';

class Indication extends StatefulWidget {
  const Indication({super.key});

  @override
  State<Indication> createState() => _IndicationState();
}

class _IndicationState extends State<Indication> {
  final FormDataController controller = Get.find();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimerProvider>(context, listen: false)
          .startTimer(seconds: 10);
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
          controllerRating.updateRating(null);
          timerProvider.resetTimer(seconds: 10);
        }
      });
    }

    return GestureDetector(
        onTap: () {
          timerProvider.startTimer(seconds: 10);
        },
        child: Background(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Em uma escala de ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '0',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' a ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '10',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' o quanto você indicaria a experiência de hoje para amigos e familiares?',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 15.0,
                children: List.generate(11, (index) {
                  Color boxColor;
                  switch (index) {
                    case 0:
                      boxColor = Color(0xFF800020);
                      break;
                    case 1:
                      boxColor = Color(0xFFFF0000);
                      break;
                    case 2:
                      boxColor = Color(0xFFFF4500);
                      break;
                    case 3:
                      boxColor = Color(0xFFFFA500);
                      break;
                    case 4:
                      boxColor = Color(0xFFFFD700);
                      break;
                    case 5:
                      boxColor = Color(0xFFFFFF00);
                      break;
                    case 6:
                      boxColor = Color(0xFFE2E2AC);
                      break;
                    case 7:
                      boxColor = Color(0xFF98FB98);
                      break;
                    case 8:
                      boxColor = Color(0xFF98FB98);
                      break;
                    case 9:
                      boxColor = Color(0xFF00FF00);
                      break;
                    case 10:
                      boxColor = Color(0xFF008000);
                      break;
                    default:
                      boxColor = Color(0xFF800020);
                  }
                  return Obx(() {
                    double opacity =
                        controllerRating.rating.value == index ? 0.1 : 1.0;
                    return ElevatedButton(
                      onPressed: () {
                        timerProvider.startTimer(seconds: 10);
                        controllerRating.updateRating(index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: boxColor.withOpacity(opacity),
                        padding: EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        '$index',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  });
                }),
              ),
              SizedBox(height: 60.0),
              ElevatedButton(
                onPressed: () {
                  if (controllerRating.rating.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                            'Por favor, avalie a experiência antes de continuar.'),
                      ),
                    );
                  } else {
                    controller.updateData(
                        indication: controllerRating.rating.value);
                    Get.to(() => Satisfaction());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
