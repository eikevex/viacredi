import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final TextEditingController commentController = TextEditingController();

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}