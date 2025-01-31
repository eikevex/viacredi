import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viacredi/binds/binds.dart';
import 'package:viacredi/controllers/formDataController.dart';
import 'package:viacredi/firebase_options.dart';
import 'package:viacredi/pages/auth.dart';
import 'package:viacredi/pages/indication.dart';
import 'package:viacredi/pages/loader.dart';
import 'package:viacredi/utils/timer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _checkUserToken() async {
    final storage = GetStorage();
    return storage.read('userToken');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _checkUserToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: BindingsBuilder(() {
            Get.put(FormDataController());
          }),
          initialRoute: '/loader',
          theme: ThemeData(
            textTheme: GoogleFonts.titilliumWebTextTheme(),
          ),
          getPages: [
            GetPage(
                name: '/auth',
                page: () => const AuthPage(),
                binding: UserBind()),
            GetPage(name: '/indication', page: () => const Indication()),
            GetPage(name: '/loader', page: () => const LogoViacredi()),
          ],
        );
      },
    );
  }
}
