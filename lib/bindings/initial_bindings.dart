import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/controllers/theme_controller.dart';
import 'package:lekol_mwen/controllers/zoom_drawer_controller.dart';
import 'package:lekol_mwen/services/firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(FirebaseStorageService());
    Get.put(AuthController(), permanent: true);
  }
}
