import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/firebase_ref/loading_status.dart';
import 'package:lekol_mwen/screens/question/test_overview.dart';
import 'package:lekol_mwen/widgets/common/background_decoration.dart';
import 'package:lekol_mwen/widgets/common/main_button.dart';
import 'package:lekol_mwen/widgets/common/question_placeholder.dart';
import 'package:lekol_mwen/widgets/content_area.dart';
import 'package:lekol_mwen/widgets/countdown_timer.dart';
import 'package:lekol_mwen/widgets/custom_app_bar.dart';
import 'package:lekol_mwen/widgets/questions/answer_card.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});
  static const String routeName = "/questionScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: onSurfaceTextColor, width: 2.0))),
            child: Obx(() => CountdownTimer(
                  time: controller.time.value.toString(),
                  color: onSurfaceTextColor,
                )),
          ),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
              "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
              style: appBarTS,
            ),
          )),
      body: BackgroundDecoration(
        child: Obx(
          () => ContentArea(
            child: Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  const Expanded(
                      child: ContentArea(child: QuestionScreenHolder())),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Text(
                            controller.currentQuestion.value!.question,
                            style: questionTS,
                          ),
                          GetBuilder<QuestionsController>(
                              id: 'answers_list',
                              builder: (context) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 25.0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];
                                      return AnswerCard(
                                        answer:
                                            '${answer.identifier}. ${answer.answer}',
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                    itemCount: controller
                                        .currentQuestion.value!.answers.length);
                              }),
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: mobileScreenPadding),
                  child: Row(
                    children: [
                      !controller.isNotFirstQuestion
                          ? const SizedBox()
                          : SizedBox(
                              width: 55.0,
                              child: MainButton(
                                onTap: () {
                                  controller.previousQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: MainButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(TestOverviewScreen.routeName)
                                  : controller.nextQuestion();
                            },
                            title: controller.isLastQuestion
                                ? "Completed"
                                : "Next",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
