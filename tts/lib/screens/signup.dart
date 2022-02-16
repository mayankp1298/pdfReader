import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tts/utils/colors.dart';
import 'package:tts/screens/bottomnavigation.dart';
import 'package:tts/screens/home.dart';
import 'package:tts/screens/signin.dart';
import 'package:tts/utils/buttons.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userControlller = TextEditingController();
  TextEditingController passwordControlller = TextEditingController();
  TextEditingController confirmPasswordControlller = TextEditingController();

  final GlobalKey<FormState> _userNameformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordNameformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordNameformKey =
      GlobalKey<FormState>();

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
            'Sign up',
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

              /// Container Confirm Password Text & TextField for confirm Password
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _confirmPasswordNameformKey,
                  child: TextFormField(
                    controller: confirmPasswordControlller,
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
                  title: "Sign up",
                  width: 0,
                ).button1(),
              ),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Text
                        const Text(
                          "already remember? ",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: LocalColors.primaryGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        /// Text
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()),
                            );
                          },
                          child: const Text(
                            "Sign in",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: LocalColors.primaryOrangeColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /* // Divider and OR container
              Container(
                margin: const EdgeInsets.only(top: 25, bottom: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      height: 1,
                      color: Colors.grey,
                    ),
                    const Text("OR"),
                    Container(
                      width: 150,
                      height: 1,
                      color: Colors.grey,
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
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
