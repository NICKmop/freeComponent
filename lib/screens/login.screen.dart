import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:freecomponent/constants/colors.constants.dart';
import 'package:freecomponent/services/firebase.service.dart';
import 'package:freecomponent/constants/common.constants.dart';
import 'package:freecomponent/screens/crawling.screen.dart';
import 'package:freecomponent/services/user.service.dart';
import 'package:freecomponent/util/logger.service.dart';
import 'package:freecomponent/models/main_view_model.dart';

import '../services/kakao_login.dart';

final googleSignIn = GoogleSignIn(
  scopes: ['email'],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final viewModel = MainViewModel(KakaoLogin());
  void _get_user_info() async {
    try {

    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: Get.size.height,
            width: Get.size.width,
            child: Column(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   "assets/images/logo.png",
                    //   width: Get.size.width / 3,
                    // ),
                    const SizedBox(height: 20),
                    const Text(
                      "로그인 스크린",
                      style: TextStyle(fontSize: 28, color: AppColors.primary),
                    ),
                    const SizedBox(height: 20),
                    SignInButton(
                      Buttons.Google,
                      text: "구글 로그인",
                      onPressed: () async {
                        print("clcke");
                        try {
                          // EasyLoading.show(status: "로그인...");
                          final account = await googleSignIn.signIn();
                          if (account == null) {
                            EasyLoading.showError("not found google account");
                            // setState(() {});
                            return;
                          }
                          final auth = await account.authentication;
                          final idToken = auth.idToken;

                          if (idToken == null) {
                            EasyLoading.showError("not found idToken");
                            return;
                          }

                          final credential = GoogleAuthProvider.credential(
                            accessToken: auth.accessToken,
                            idToken: auth.idToken,
                          );

                          // controller.oAuthCredential.value = credential;
                          final user = await FirebaseAuth.instance
                              .signInWithCredential(credential);
                          if (user.user == null) {
                            throw "handleGoogleLogin signInWithCredential errror";
                          }
                          print("222");

                          var currentUser = await FirebaseService.findUserByEmail(
                              user.user!.email!);
                          if (currentUser == null) {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user.user!.email)
                                .set({
                              "email": user.user!.email,
                              "provider": "google",
                              "createdAt": DateTime.now(),
                              "loggedAt": DateTime.now(),
                              "name": user.user!.displayName,
                              "profileImage": user.user!.photoURL,
                              'categories': [NO_CATEGORY_TEXT]
                            });
                            currentUser = await FirebaseService.findUserByEmail(
                                user.user!.email!);
                            if (currentUser == null) {
                              EasyLoading.showError("가입 실패");
                            }
                          }
                          UserService.to.currentUser.value = currentUser;
                          Get.offAll(() => const crawlingScreen());
                        } catch (error) {
                          logger.e(error);
                        } finally {
                          EasyLoading.dismiss();
                        }
                      },
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 165,
                        child: CupertinoButton(
                          onPressed: () async {
                            await viewModel.login();
                            setState(() {});
                            EasyLoading.show(status: "카카오 로그인 성공...");
                            Get.offAll(() => const crawlingScreen());
                          },
                          color: Colors.yellow,
                          padding: const EdgeInsets.all(10),
                          borderRadius: BorderRadius.circular(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.chat_bubble, color: Colors.black54),
                              SizedBox(width: 10,),
                              Text(
                                '카카오계정 로그인',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
              const Text(
                "test",
                style: TextStyle(fontSize: 20, color: AppColors.primary),
              ),
              const SizedBox(height: 20),
            ]),
          ),
        ));
  }
}

