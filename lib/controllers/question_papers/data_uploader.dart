import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lekol_mwen/firebase_ref/loading_status.dart';
import 'package:lekol_mwen/firebase_ref/references.dart';
import 'package:lekol_mwen/models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  void uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();

    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String paperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(paperContent)));
    }
    var batch = fireStore.batch();

    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions?.length ?? 0
      });
      for (var question in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: question.id);
        batch.set(questionPath, {
          "question": question.question,
          "correct_answer": question.correctAnswer
        });

        for (var answer in question.answers) {
          batch.set(questionPath.collection("answers").doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
