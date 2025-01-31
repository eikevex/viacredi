import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:get/get.dart';
import 'package:viacredi/controllers/userController.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui_auth;
import 'package:viacredi/services/firebase_service.dart';
import 'package:viacredi/utils/randomizerUtils.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _sendAgency() async {
    String city = getRandomCity();
    String agency = getRandomAgency();

    try {
      await _firebaseService.sendAgencyData(
        agencyId: user!.uid, // Usa o UID do usuário como agencyId
        city: city,
        name: agency,
        state: 'SC',
      );
      print("Dados da agência enviados com sucesso!");
    } catch (e) {
      print("Erro ao enviar dados da agência: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    if (user != null) {
      Get.offNamed('/indication');
    }
  }

  @override
  Widget build(BuildContext context) {
    final providers = [firebase_ui_auth.EmailAuthProvider()];

    return SignInScreen(
      providers: providers,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) async {
          Get.find<UserController>().setUserToken = await state.user?.getIdToken();
          Get.offNamed('/indication', arguments: {'type': 'signedIn'});
        }),
        AuthStateChangeAction<UserCreated>((context, state) async {
          user = state.credential.user;    
          await _sendAgency();
          Get.offNamed('/indication', arguments: {'type': 'userCreated'});
        }),
      ],
      headerBuilder: (context, constraints, shrinkOffset) {
        return Image.asset(
          'assets/icons/favicon.jpg',
          height: constraints.maxHeight,
          width: constraints.maxWidth,
        );
      },
      sideBuilder: (context, constraints) {
        return Image.asset(
          'assets/icons/favicon.jpg',
          height: constraints.maxHeight,
          width: constraints.maxWidth,
        );
      },
    );
  }
}