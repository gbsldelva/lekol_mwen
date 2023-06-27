import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/bindings/initial_bindings.dart';
import 'package:lekol_mwen/configs/themes/app_dark_theme.dart';
import 'package:lekol_mwen/configs/themes/app_light_theme.dart';
import 'package:lekol_mwen/controllers/theme_controller.dart';
import 'package:lekol_mwen/data_uploader_screen.dart';
import 'package:lekol_mwen/firebase_options.dart';
import 'package:lekol_mwen/routes/app_routes.dart';
import 'package:lekol_mwen/screens/introduction/introduction.dart';
import 'package:lekol_mwen/screens/splash/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Get.find<ThemeController>().lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes(),
    );
  }
}
