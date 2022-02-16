import 'package:flutter/material.dart';
import 'package:tts/downloadpdf.dart';
import 'package:tts/utils/colors.dart';
import 'package:tts/screens/home.dart';
import 'package:tts/viewpdf.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  var height;
  var width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  // ViewPDF(),
                  DownloadPDF(),
                  Home(),
                  Home(),
                  Home(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: LocalColors.primaryBlackColor,
          showUnselectedLabels: true,

          currentIndex: pageIndex,
          type: BottomNavigationBarType.shifting,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: LocalColors.primaryGreyColor,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.home,
                color: LocalColors.primaryOrangeColor,
                size: 30,
              ),
              label: "Home",
              backgroundColor: LocalColors.primaryWhiteColor,
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.category_outlined,
                color: LocalColors.primaryGreyColor,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.category_outlined,
                color: LocalColors.primaryOrangeColor,
                size: 30,
              ),
              label: "Categories",
              backgroundColor: LocalColors.primaryWhiteColor,
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.library_add_check,
                color: LocalColors.primaryGreyColor,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.library_add_check,
                color: LocalColors.primaryOrangeColor,
                size: 30,
              ),
              label: "My Library",
              backgroundColor: LocalColors.primaryWhiteColor,
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: LocalColors.primaryGreyColor,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.person,
                color: LocalColors.primaryOrangeColor,
                size: 30,
              ),
              label: "Profile",
              backgroundColor: LocalColors.primaryWhiteColor,
            ),
          ],
          onTap: (index) async {
            setState(() {
              pageController.jumpToPage(index);
              pageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
