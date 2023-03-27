import 'package:flutter/material.dart';
import 'package:shopping_app/modules/shop_login_screen/shop_login_screen.dart';
import 'package:shopping_app/remote/local/cache_helper.dart';
import 'package:shopping_app/shared_components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.body,
    required this.title,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      body: 'You can Shop in our program easier and you will find everything you need with us',
      title: 'Easy Shopping',
      image: 'assets/images/img.png',
    ),
    BoardingModel(
      body: 'You will pay with ease and complete safety and under our supervision',
      title: 'Secure Payment',
      image: 'assets/images/img2.jpeg',
    ),
    BoardingModel(
      body: 'We have the best, safest and fastest delivery methods ever',
      title: 'Quick Delivery',
      image: 'assets/images/img3.jpeg',
    ),
  ];

  var boardController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
              {
                navigateAndFinish(
                    context: context, widget: const ShopLoginScreen());
              });
            },
            child: Text(
              'SKIP',
              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontFamily: 'Jannah',
                  ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
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
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    boardingItemBuilder(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      expansionFactor: 4,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: (){
                      if (isLast) {
                        CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
                        {
                          navigateAndFinish(
                              context: context, widget: const ShopLoginScreen());
                        });
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.decelerate,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget boardingItemBuilder(BoardingModel model) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image(
                  width: double.infinity,
                  height: 400.0,
                  fit: BoxFit.cover,
                  image: AssetImage(model.image),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              model.title,
              style: const TextStyle(fontSize: 24, fontFamily: 'Jannah'),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Text(
              model.body,
              style: const TextStyle(fontSize: 14, fontFamily: 'Jannah',color: Colors.black54,),
            ),
          ],
        ),
      );
}
