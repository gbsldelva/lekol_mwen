import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/auth_controller.dart';
import 'package:lekol_mwen/firebase_ref/references.dart';
import 'package:lekol_mwen/models/question_paper_model.dart';
import 'package:lekol_mwen/screens/question/question_screen.dart';
import 'package:lekol_mwen/services/firebase_storage_service.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();

      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imageUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        if (imageUrl != null) {
          allPaperImages.add(imageUrl);
          paper.imageUrl = imageUrl;
        }
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel model, bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionsScreen.routeName,
            arguments: model, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionsScreen.routeName, arguments: model);
      }
    } else {
      _authController.showLoginAlertDialogue();
    }
  }
}
