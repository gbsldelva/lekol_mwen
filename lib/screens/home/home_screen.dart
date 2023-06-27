import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/configs/themes/app_icons.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/question_papers/question_paper_controller.dart';
import 'package:lekol_mwen/controllers/zoom_drawer_controller.dart';
import 'package:lekol_mwen/widgets/content_area.dart';
import 'package:lekol_mwen/screens/home/menu_screen.dart';
import 'package:lekol_mwen/screens/home/question_card.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});
  static const String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            angle: 0.0,
            slideWidth: MediaQuery.of(context).size.width * 0.8,
            borderRadius: 50.0,
            style: DrawerStyle.defaultStyle,
            menuBackgroundColor: Colors.transparent,
            controller: _.zoomDrawerController,
            menuScreen: const MenuScreen(),
            mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.toogleDrawer();
                            },
                            child: const Icon(
                              AppIcons.menuLeft,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              children: [
                                const Icon(
                                  AppIcons.peace,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text("Hello student.",
                                    style: detailText.copyWith(
                                      color: onSurfaceTextColor,
                                    )),
                              ],
                            ),
                          ),
                          const Text(
                            "What do you want to learn today?",
                            style: headerText,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ContentArea(
                            addPadding: false,
                            child: Obx(
                              () => ListView.separated(
                                  padding: UIParameters.mobileScreenPadding,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return QuestionCard(
                                        questionModel: questionPaperController
                                            .allPapers[index]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 20.0,
                                    );
                                  },
                                  itemCount:
                                      questionPaperController.allPapers.length),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
