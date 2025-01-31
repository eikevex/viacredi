import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/pages/thanks.dart';
import 'package:viacredi/utils/timer.dart';

import 'package:viacredi/widgets/background.dart';

import 'cpf.dart';

class CpfQuestion extends StatefulWidget {
  const CpfQuestion({super.key});

  @override
  State<CpfQuestion> createState() => _CpfQuestionState();
}

class _CpfQuestionState extends State<CpfQuestion> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimerProvider>(context, listen: false).resetTimer();
    });
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
    return GestureDetector(
      onTap: timerProvider.resetTimer,
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Text(
              'Gostaria de informar seu CPF?',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 70),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => Cpf());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(100, 60),
                  ),
                  child: Text(
                    'Sim',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ThanksPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: Size(100, 60),
                  ),
                  child: Text(
                    'Não',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
