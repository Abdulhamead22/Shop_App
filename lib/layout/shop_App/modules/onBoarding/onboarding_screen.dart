import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/shop_App/modules/login/shop_login_screen.dart';
import 'package:flutter_application_1/layout/widget/widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/*
  boarderController.nextPage(//للتحكم في الصفحة
    duration: Duration(),//للتجكم في التوقيت للننقل
    curve: Curves.fastLinearToSlowEaseIn//للتحكم في شكل الحركة عند التنقل بين الصفحات
  SmoothPageIndicator(
    controller: boarderController,
    count: boardingModel.length,
    effect: ExpandingDotsEffect(),//للتحكم في تصميم 
              ), 
      Navigator.pushAndRemoveUntil: بعمل انتقال وبسكر الي قبلو
        (route) {
          return false;
          اذا كانت خطأ بتلغي الي قبلها كانت صح بتخلي
            },
 */
class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel(this.image, this.title, this.body);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<BoardingModel> boardingModel = [
    BoardingModel('assets/page1.png', "Title1", 'Body1'),
    BoardingModel('assets/page1.png', "Title2", 'Body2'),
    BoardingModel('assets/page1.png', "Title3", 'Body3')
  ];

  final boarderController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submitToBoarding();
            },
            text: "SKIP",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boarderController,
                itemBuilder: (context, index) {
                  return buildBoardingItem(boardingModel[index]);
                },
                itemCount: boardingModel.length,
                onPageChanged: (value) {
                  if (value == boardingModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                    print("last");
                  } else {
                    setState(() {
                      isLast = false;
                    });

                    print("not last");
                  }
                },
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boarderController,
                  count: boardingModel.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.pinkAccent,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.pinkAccent,
                  onPressed: () {
                    if (isLast) {
                      submitToBoarding();
                    } else {
                      boarderController.nextPage(
                        duration: const Duration(seconds: 3),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.east_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(height: 30),
        Text(model.title),
        const SizedBox(height: 30),
        Text(model.body),
        const SizedBox(height: 30),
      ],
    );
  }

  void submitToBoarding() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then(
      (value) {
        if (value) {
          navigatFinish(context, const LoginScreen());
        }
      },
    );
  }
}
