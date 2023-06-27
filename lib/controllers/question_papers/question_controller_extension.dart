import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/firebase_ref/references.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) * 100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) return;
    batch.set(
        userRF
            .doc(user.email)
            .collection("myrecent_tests")
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_answer": '$correctQuestionCount/${allQuestions.length}',
          "question_id": questionPaperModel.id,
        });
    batch.commit();
    navigateToHome();
  }
}
