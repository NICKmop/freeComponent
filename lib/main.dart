import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:freecomponent/services/user.service.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'constants/common.constants.dart';
import 'screens/splash.screen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    KakaoSdk.init(nativeAppKey: KAKAO_NATIVE_APP_KEY);
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: const cra.crawlingScreen(),
      initialBinding: BindingsBuilder((){
        Get.put(UserService());
      }),
    );
  }
}
