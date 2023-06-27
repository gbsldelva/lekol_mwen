import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/question_papers/question_controller_extension.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/screens/question/answer_check_screen.dart';
import 'package:lekol_mwen/widgets/common/background_decoration.dart';
import 'package:lekol_mwen/widgets/common/main_button.dart';
import 'package:lekol_mwen/widgets/content_area.dart';
import 'package:lekol_mwen/widgets/custom_app_bar.dart';
import 'package:lekol_mwen/widgets/questions/answer_card.dart';
import 'package:lekol_mwen/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});
  static const routeName = '/resultscreen';

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      appBar: CustomAppBar(
        leading: const SizedBox(height: 80.0),
        title: controller.correctAnsweredQuestions,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        child: ContentArea(
          child: Column(
            children: [
              Expanded(
                child: Column(children: [
                  SvgPicture.asset('assets/images/bulb.svg'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 5.0),
                    child: Text(
                      'Congratulations',
                      style: headerText.copyWith(color: _textColor),
                    ),
                  ),
                  Text(
                    'You have ${controller.points} points',
                    style: TextStyle(color: _textColor),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const Text(
                    'Tap below question numbers to view correct answers',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 70,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0),
                        itemBuilder: (_, index) {
                          final question = controller.allQuestions[index];
                          AnswerStatus status = AnswerStatus.notanswered;
                          final String? selectedAnswer =
                              question.selectedAnswer;
                          final correctAnswer = question.correctAnswer;
                          if (selectedAnswer == correctAnswer) {
                            status = AnswerStatus.correct;
                          } else if (question.selectedAnswer == null) {
                            status = AnswerStatus.wrong;
                          } else {
                            status = AnswerStatus.wrong;
                          }

                          return QuestionNumberCard(
                            index: index + 1,
                            status: status,
                            onTap: () {
                              controller.jumpToQuestion(index, goBack: false);
                              Get.toNamed(AnswerCheckScreen.routeName);
                            },
                          );
                        }),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: mobileScreenPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: const Color(0xFF2A3C65).withOpacity(0.25),
                        title: 'Try again',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.saveTestResults();
                        },
                        color: const Color(0xFF2A3C65).withOpacity(0.25),
                        title: 'Go Home',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
