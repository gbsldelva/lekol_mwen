import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_icons.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/screens/question/test_overview.dart';
import 'package:lekol_mwen/widgets/app_circle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.showActionIcon = false,
      this.onMenuActionTap,
      this.leading});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
        child: InkWell(
          child: Stack(
            children: [
              Positioned.fill(
                child: titleWidget == null
                    ? Center(
                        child: Text(
                          title,
                          style: appBarTS,
                        ),
                      )
                    : Center(child: titleWidget),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading ??
                      Transform.translate(
                        offset: const Offset(14, 0),
                        child: const BackButton(),
                      ),
                  if (showActionIcon)
                    Transform.translate(
                      offset: const Offset(-10, 0),
                      child: InkWell(
                        onTap: onMenuActionTap ??
                            () {
                              Get.toNamed(TestOverviewScreen.routeName);
                            },
                        child: const Icon(AppIcons.menu),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80.0);
}
