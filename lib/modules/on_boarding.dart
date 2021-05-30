import 'package:flutter/material.dart';
import 'package:shop_app/models/components.dart';
import 'package:shop_app/modules/login_screen.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({this.title, this.body, this.image});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submitBoarding(BuildContext context)async {
    await CacheHelper.saveData(key: 'onBoarding',value: true).then((value) {
      if(value){
        navigateandFinish(context, LoginScreen());
      }
    });


  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard1.png', title: 'Title 1', body: 'Body 1'),
    BoardingModel(
        image: 'assets/images/onboarding2.jpg',
        title: 'Title 2',
        body: 'Body 2'),
    BoardingModel(
        image: 'assets/images/onboarding3.jpg',
        title: 'Title 3',
        body: 'Body 3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
               submitBoarding(context);
              },
              child: Text(
                'SKIP',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                     submitBoarding(context);
                    } else {
                      boardController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildBoardingItem(BoardingModel boarding) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(boarding.image),
        )),
        SizedBox(
          height: 30,
        ),
        Text(boarding.title),
        SizedBox(
          height: 30,
        ),
        Text(boarding.body),
      ],
    );
  }
}
