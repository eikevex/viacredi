import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viacredi/pages/comments.dart';

class CpfUtils {
  static void validateAndShowResult({
    required String cpf,
    required TextEditingController controller,
    required BuildContext context,
    required void Function(String) showErrorMessage,
  }) {
    bool isValid = CPFValidator.isValid(cpf);

    if (isValid) {
      Get.to(() => const Comments());
    } else {
      showErrorMessage("Por favor, digite um CPF válido!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, digite um CPF válido!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}