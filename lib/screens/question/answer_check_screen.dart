import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/screens/question/result_screen.dart';
import 'package:lekol_mwen/widgets/common/background_decoration.dart';
import 'package:lekol_mwen/widgets/content_area.dart';
import 'package:lekol_mwen/widgets/custom_app_bar.dart';
import 'package:lekol_mwen/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});
  static const String routeName = '/answercheckscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.offNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
          child: Obx(() => ContentArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(controller.currentQuestion.value!.question),
                      GetBuilder<QuestionsController>(
                        id: 'answer_review_list',
                        builder: (_) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              final answer = controller
                                  .currentQuestion.value!.answers[index];
                              final selectedAnswer = controller
                                  .currentQuestion.value!.selectedAnswer;
                              final correctAnswer = controller
                                  .currentQuestion.value!.correctAnswer;
                              final String answerText =
                                  '${answer.identifier}. ${answer.answer}';

                              if (correctAnswer == selectedAnswer &&
                                  answer.identifier == selectedAnswer) {
                                return CorrectAnswer(answer: answerText);
                              } else if (selectedAnswer == null) {
                                // user didn't choose an answer
                                return NotAnswered(answer: answerText);
                              } else if (correctAnswer != selectedAnswer &&
                                  answer.identifier == selectedAnswer) {
                                // answer is wrong
                                return WrongAnswer(
                                  answer: answerText,
                                );
                              } else if (correctAnswer == answer.identifier) {
                                // correct answer not selected by user
                                return CorrectAnswer(
                                  answer: answerText,
                                );
                              }

                              return AnswerCard(
                                answer: answerText,
                                onTap: () {},
                                isSelected: false,
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 10.0,
                              );
                            },
                            itemCount: controller
                                .currentQuestion.value!.answers.length,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
