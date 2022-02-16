import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tts/utils/colors.dart';
import 'package:tts/screens/signup.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController controller = PageController();

  int currentPageValue = 0;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        PageView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: 3,
          onPageChanged: (int page) {
            getChangedPageAndMoveBar(page);
          },
          controller: controller,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        color: LocalColors.primaryGreyColor,
                        height: 300,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: const Text(
                          "Welcome",
                          style: TextStyle(
                            color: LocalColors.primaryBlackColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: const Text(
                    "Praesent tellus mauris, tincidunt nec ipsum id, faucibus pellentesque leo. Nunc congue ac tellus quis porttitor. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: LocalColors.primaryBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log("\nCurrent Page Value : $currentPageValue\n");

                    if (currentPageValue == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    } else {
                      currentPageValue++;
                      //getChangedPageAndMoveBar(currentPageValue);
                      controller.jumpToPage(currentPageValue);
                    }
                  },
                  child: Container(
                    height: 60,
                    color: LocalColors.primaryOrangeColor,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Center(
                      child: Text(
                        currentPageValue == 2 ? "Getting Started" : "Next",
                        style: const TextStyle(
                          color: LocalColors.primaryWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 35),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < 3; i++)
                    if (i == currentPageValue) ...[circleBar(true)] else
                      circleBar(false),
                ],
              ),
            ),
          ],
        ),
        /* Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              if (currentPageValue == 2) {
                /*  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateProfilePage()),
                ); */
              } else {
                controller.jumpToPage(2);
              }
            },
            child: Text(
              currentPageValue == 2 ? "Next" : "Skip",
              /*  style: width > 650
                  ? subtitleText
                  : TextStyle(
                      color: AppColor.lightMetal,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ), */
            ),
          ),
        ) ,*/
      ],
    ));
  }

  void getChangedPageAndMoveBar(int page) {
    log("\nCurrent Page Value 1 : $currentPageValue\n");
    currentPageValue = page;

    log("\nCurrent Page Value 2 : $currentPageValue\n");
    setState(() {});
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.grey : Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
