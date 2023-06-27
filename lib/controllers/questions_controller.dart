import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/controllers/question_papers/question_paper_controller.dart';
import 'package:lekol_mwen/firebase_ref/loading_status.dart';
import 'package:lekol_mwen/firebase_ref/references.dart';
import 'package:lekol_mwen/models/question_paper_model.dart';
import 'package:lekol_mwen/screens/question/result_screen.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Question>[];
  Rxn<Question> currentQuestion = Rxn<Question>();
  final loadingStatus = LoadingStatus.loading.obs;
  final questionIndex = 0.obs;
  bool get isNotFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  //Timer
  Timer? _timer;
  int remainSeconds = 0;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionPaperModel;
    loadData(questionPaper);
    super.onReady();
  }

  void loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = loadingStatus.value;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => Question.fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;
      for (Question question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answer.fromSnapshot(answer))
            .toList();
        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
    _startTimer(questionPaper.timeSeconds);
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review_list']);
  }

  String get testCompleted {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered  out of ${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool goBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (goBack) {
      Get.back();
    }
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void previousQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainSeconds--;
      }
    });
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void tryAgain() {
    questionIndex.value = 0;
    Get.find<QuestionPaperController>()
        .navigateToQuestions(model: questionPaperModel, tryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil("/home", (route) => false);
  }
}
