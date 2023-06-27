import 'package:flutter/material.dart';
import 'package:lekol_mwen/configs/themes/app_colors.dart';
import 'package:lekol_mwen/configs/themes/ui_parameters.dart';

enum AnswerStatus {
  correct,
  wrong,
  answered,
  notanswered;
}

class AnswerCard extends StatelessWidget {
  final bool isSelected;
  final String answer;
  final VoidCallback onTap;
  const AnswerCard(
      {super.key,
      this.isSelected = false,
      required this.answer,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color:
              isSelected ? answerSelectedColor() : Theme.of(context).cardColor,
          border: Border.all(
            color: isSelected ? answerSelectedColor() : answerBorderColor(),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Text(
          answer,
          style: TextStyle(color: isSelected ? onSurfaceTextColor : null),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1),
      ),
      child: Text(
        answer,
        style: const TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({super.key, required this.answer});
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: notAnsweredColor.withOpacity(0.1)),
      child: Text(
        answer,
        style: const TextStyle(
            color: notAnsweredColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
