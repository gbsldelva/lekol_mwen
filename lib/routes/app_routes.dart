import 'package:get/get.dart';
import 'package:lekol_mwen/controllers/question_papers/question_paper_controller.dart';
import 'package:lekol_mwen/controllers/questions_controller.dart';
import 'package:lekol_mwen/controllers/zoom_drawer_controller.dart';
import 'package:lekol_mwen/screens/home/home_screen.dart';
import 'package:lekol_mwen/screens/introduction/introduction.dart';
import 'package:lekol_mwen/screens/login/login_screen.dart';
import 'package:lekol_mwen/screens/question/answer_check_screen.dart';
import 'package:lekol_mwen/screens/question/question_screen.dart';
import 'package:lekol_mwen/screens/question/result_screen.dart';
import 'package:lekol_mwen/screens/question/test_overview.dart';

import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
            name: "/home",
            page: () => const HomeScreen(),
            binding: BindingsBuilder(() {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            })),
        GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
        GetPage(
          name: QuestionsScreen.routeName,
          page: () => const QuestionsScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
          }),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
      ];
}
