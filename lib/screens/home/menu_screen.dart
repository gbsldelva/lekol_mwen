import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/configs/themes/app_light_theme.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/zoom_drawer_controller.dart';
import 'package:lekol_mwen/screens/login/login_screen.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      color: primaryColorLight,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: controller.isLoggedIn(),
              child: UserAccountsDrawerHeader(
                accountName: Obx(
                  () => _TextMenu(
                    controller.user.value?.displayName ?? "Name",
                  ),
                ),
                accountEmail:
                    Obx(() => Text(controller.user.value?.email ?? "Email")),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Obx(() => Image.network(
                        controller.user.value?.photoURL ?? "UrlPic"),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !controller.isLoggedIn(),
              child: InkWell(
                onTap: () {
                  Get.toNamed(LoginScreen.routeName);
                },
                child: const ListTile(
                  title: _TextMenu('Log In'),
                  leading: Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: _TextMenu('Home Page'),
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: _TextMenu('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
            Visibility(
              visible: controller.isLoggedIn(),
              child: InkWell(
                onTap: () {
                  controller.signOut();
                },
                child: const ListTile(
                  title: _TextMenu('Log Out'),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextMenu extends StatelessWidget {
  final String label;

  const _TextMenu(
    this.label,
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
    );
  }
}
