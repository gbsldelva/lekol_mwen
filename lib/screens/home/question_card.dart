import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/configs/themes/app_icons.dart';
import 'package:lekol_mwen/configs/themes/custom_text_styles.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';
import 'package:lekol_mwen/controllers/question_papers/question_paper_controller.dart';
import 'package:lekol_mwen/models/question_paper_model.dart';
import 'package:lekol_mwen/widgets/app_icon_text_button.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  final QuestionPaperModel questionModel;
  const QuestionCard({super.key, required this.questionModel});

  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: GestureDetector(
        onTap: () {
          controller.navigateToQuestions(model: questionModel);
        },
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: questionModel.imageUrl!,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/no_image.jpg"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(questionModel.title, style: cardTitles(context)),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 1.0, bottom: 15.0),
                          child: Text(questionModel.description),
                        ),
                        Row(
                          children: [
                            AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                '${questionModel.questionCount} questions',
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                questionModel.timeInMinutes(),
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: -padding,
                right: -padding,
                child: GestureDetector(
                    child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(cardBorderRadius),
                      bottomRight: Radius.circular(cardBorderRadius),
                    ),
                  ),
                  child: const Icon(AppIcons.trophyOutline),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
