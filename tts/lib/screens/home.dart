import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tts/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LocalColors.primaryWhiteColor,
        appBar: AppBar(
          leading: const Icon(
            Icons.dehaze_sharp,
            color: LocalColors.primaryBlackColor,
            size: 30,
          ),
          actions: const [
            Icon(
              Icons.search,
              color: LocalColors.primaryBlackColor,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
          ],
          backgroundColor: LocalColors.primaryWhiteColor,
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: const Text(
            'Home',
            style: TextStyle(
              color: LocalColors.primaryBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Featured",
                style: TextStyle(
                  color: LocalColors.primaryBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 300,
                //color: LocalColors.primaryOrangeColor,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    //padding: const EdgeInsets.all(8),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            color: LocalColors.secondaryGreyColor,
                            width: 200,
                            height: 230,
                          ),
                          Container(
                            height: 30,
                            color: LocalColors.primaryWhiteColor,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: const Text(
                              "Lavinya",
                              style: TextStyle(
                                color: LocalColors.primaryBlackColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                          )
                        ],
                      );
                    }),
              ),
              const Text(
                "Featured",
                style: TextStyle(
                  color: LocalColors.primaryBlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  //height: 300,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              color: LocalColors.secondaryGreyColor,
                              width: 150,
                              height: 150,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: LocalColors.primaryWhiteColor,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: const Text(
                                    "Wake Up To Happiness",
                                    style: TextStyle(
                                      color: LocalColors.primaryBlackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  color: LocalColors.primaryWhiteColor,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: const Text(
                                    "Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie Etiam eleifend sapie",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: LocalColors.primaryBlackColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
