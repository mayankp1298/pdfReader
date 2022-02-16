import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tts/utils/colors.dart';
import 'package:tts/screens/bottomnavigation.dart';
import 'package:tts/screens/home.dart';
import 'package:tts/utils/buttons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //var height, width;

  TextEditingController userControlller = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();

  final GlobalKey<FormState> _userNameformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordNameformKey = GlobalKey<FormState>();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: LocalColors.primaryWhiteColor,
        appBar: AppBar(
          backgroundColor: LocalColors.primaryWhiteColor,
          centerTitle: true,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: const Text(
            'Sign in',
            style: TextStyle(
              color: LocalColors.primaryBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Container UserName Text & TextField for UserName
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _userNameformKey,
                  child: TextFormField(
                    controller: userControlller,
                    validator: (teamName) {
                      if (teamName!.isEmpty) {
                        return '* email id required';
                      }
                    },
                    decoration: const InputDecoration(
                      /*  suffixIcon: Icon(
                        Icons.supervised_user_circle,
                      ), */
                      filled: true,
                      fillColor: LocalColors.primaryWhiteColor,
                      labelText: 'Email',
                      //labelStyle: minihint,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    ),
                    onChanged: (_) {
                      if (_userNameformKey.currentState!.validate()) {
                        log('valid');
                      }
                    },
                    onFieldSubmitted: (_) {
                      if (_userNameformKey.currentState!.validate()) {
                        log('valid');
                      }
                    },
                  ),
                ),
              ),

              /// Container Password Text & TextField for Password
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _passwordNameformKey,
                  child: TextFormField(
                    controller: passwordControlller,
                    validator: (teamName) {
                      if (teamName!.isEmpty) {
                        return '* password can not be empty';
                      }
                      if (teamName.length < 3) {
                        return '* password is too short';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      /*  suffixIcon: Icon(
                        Icons.lock_outlined,
                      ), */

                      filled: true,
                      fillColor: LocalColors.primaryWhiteColor,
                      labelText: 'Password',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    ),
                    onChanged: (_) {
                      if (_passwordNameformKey.currentState!.validate()) {
                        log('valid');
                      }
                    },
                  ),
                ),
              ),

              /// Forgot Password Text
              Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  "Forgot Password ",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: LocalColors.primaryOrangeColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor: const Color(0xff00C8E8),
                      ),
                      child: Checkbox(
                        activeColor: const Color(0xff00C8E8),
                        checkColor: const Color(0xffF78500),
                        value: value,
                        onChanged: (v) {
                          value = v!;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  const Text(
                    "Remember Me",
                    style: TextStyle(
                      color: LocalColors.primaryGreyColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ]),
              ),

              // Sign In Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()));
                },
                child: Buttons(
                  borderRadius: 15,
                  fontSize: 20,
                  height: 50,
                  primaryBoxColor: LocalColors.primaryOrangeColor,
                  primaryTextColor: LocalColors.primaryWhiteColor,
                  title: "Sign in",
                  width: 0,
                ).button1(),
              ),

              // Divider and OR container
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      height: 1,
                      color: LocalColors.primaryGreyColor,
                    ),
                    const Text("OR"),
                    Container(
                      width: 150,
                      height: 1,
                      color: LocalColors.primaryGreyColor,
                    ),
                  ],
                ),
              ),

              // Container for Facebook and Twitter Login
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Buttons(
                      borderRadius: 25,
                      fontSize: 17,
                      height: 50,
                      primaryBoxColor: LocalColors.primaryBlueColor,
                      primaryTextColor: LocalColors.primaryWhiteColor,
                      title: "Facebook",
                      width: 160,
                    ).button2(),
                    Buttons(
                      borderRadius: 25,
                      fontSize: 17,
                      height: 50,
                      primaryBoxColor: LocalColors.secondaryBlueColor,
                      primaryTextColor: LocalColors.primaryWhiteColor,
                      title: "Twitter",
                      width: 160,
                    ).button2(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
