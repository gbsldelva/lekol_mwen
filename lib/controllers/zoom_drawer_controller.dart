import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/screens/login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  bool isLoggedIn() {
    return Get.find<AuthController>().isLoggedIn();
  }

  void signIn() {
    Get.offAllNamed(LoginScreen.routeName);
  }

  void email() {
    final Uri emailLauchUri =
        Uri(scheme: 'mailto', path: 'gbsldelva@gmail.com');
    _launch(emailLauchUri.toString());
  }

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Coul not lauch $url';
    }
  }
}
