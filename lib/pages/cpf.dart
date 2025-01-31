import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/controllers/cpfController.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/utils/cpfUtils.dart';
import 'package:viacredi/utils/timer.dart';
import 'package:viacredi/widgets/background.dart';
import 'package:viacredi/widgets/buildButtons.dart';
import 'package:viacredi/widgets/sendButton.dart';

class Cpf extends StatefulWidget {
  const Cpf({super.key});

  @override
  State<Cpf> createState() => _CpfState();
}

class _CpfState extends State<Cpf> {
  final _cpfController = CpfController();
  FocusNode focusNode = FocusNode();
  String validationMessage = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TimerProvider>(context, listen: false).resetTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final FormDataController controller = Get.find();
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _cpfController.cpfTextController,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      readOnly: true,
                      focusNode: focusNode,
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (int i = 1; i < 10; i++)
                          NumberButton(
                            number: i,
                            controller: _cpfController.cpfTextController,
                          ),
                        const SizedBox(width: 69),
                        const SizedBox(width: 24),
                        NumberButton(
                          number: 0,
                          controller: _cpfController.cpfTextController,
                        ),
                        BackspaceButton(
                            controller: _cpfController.cpfTextController),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SendButton(
                onPressed: () {
                  CpfUtils.validateAndShowResult(
                    cpf: _cpfController.cpfTextController.text,
                    controller: _cpfController.cpfTextController,
                    context: context,
                    showErrorMessage: (message) {
                      setState(() {
                        validationMessage = message;
                      });
                    },
                  );
                  controller.updateData(
                    cpf: _cpfController.cpfTextController.text,
                  );             
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
