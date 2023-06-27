import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/widgets/common/background_decoration.dart';
import 'package:lekol_mwen/widgets/common/main_button.dart';
import 'package:lekol_mwen/widgets/content_area.dart';
import 'package:lekol_mwen/widgets/countdown_timer.dart';
import 'package:lekol_mwen/widgets/custom_app_bar.dart';
import 'package:lekol_mwen/widgets/questions/answer_card.dart';
import 'package:lekol_mwen/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({Key? key});
  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.testCompleted,
      ),
      body: BackgroundDecoration(
        child: ContentArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountdownTimer(
                          time: '',
                          color: UIParameters.isDarkMode()
                              ? Theme.of(context).textTheme.bodyLarge!.color
                              : Theme.of(context).primaryColor,
                        ),
                        Obx(
                          () => Text(
                            '${controller.time.value} Remaining',
                            style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: UIParameters.isDarkMode()
                                  ? Theme.of(context).textTheme.bodyLarge!.color
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.allQuestions.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: Get.width ~/ 70,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0),
                          itemBuilder: (_, index) {
                            AnswerStatus? answerStatus;
                            if (controller.allQuestions[index].selectedAnswer !=
                                null) {
                              answerStatus = AnswerStatus.answered;
                            }
                            return QuestionNumberCard(
                                index: index + 1,
                                status: answerStatus,
                                onTap: () {
                                  controller.jumpToQuestion(index);
                                });
                          }),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(mobileScreenPadding),
                child: Expanded(
                  child: MainButton(
                    onTap: () => controller.complete(),
                    title: 'Complete',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
