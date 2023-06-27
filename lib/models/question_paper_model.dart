import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Question>? questions;
  int questionCount;

  QuestionPaperModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Question.fromJson(e as Map<String, dynamic>))
            .toList();

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'],
        timeSeconds = json['time_seconds'],
        questionCount = json['questions_count'] as int,
        questions = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['Description'] = description;
    data['time_seconds'] = timeSeconds;

    return data;
  }
}

class Question {
  String id;
  String question;
  List<Answer> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Question(
      {required this.id,
      required this.question,
      required this.answers,
      this.correctAnswer});

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
            (json['answers'] as List).map((e) => Answer.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Question.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['answers'] = answers.map((v) => v.toJson()).toList();

    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answer {
  String? identifier;
  String? answer;

  Answer({required this.identifier, required this.answer});

  Answer.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'] as String,
        answer = json['Answer'] as String;

  Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapsot)
      : identifier = snapsot.id,
        answer = snapsot['answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}
