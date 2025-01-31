import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/controllers/commentsController.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/pages/thanks.dart';
import 'package:viacredi/widgets/background.dart';

import '../utils/timer.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final FocusNode _focusNode = FocusNode();
  final CommentController _commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    _commentController.commentController.text = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<TimerProvider>(context, listen: false).startTimer();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Deixe seu comentário',
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.updateData(
                      comment: _commentController.commentController.text,
                    );
                    Get.to(() => ThanksPage());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Finalizar comentário'),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              width: 700,
              child: TextField(
                style: TextStyle(),
                controller: _commentController.commentController,
                focusNode: _focusNode,
                textInputAction: TextInputAction.send,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onSubmitted: (text) {
                  controller.updateData(
                    comment: _commentController.commentController.text,
                  );
                  Get.to(() => ThanksPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
