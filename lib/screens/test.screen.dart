import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';



class testScreen extends StatefulWidget {
  const testScreen({Key? key}) : super(key: key);

  @override
  State<testScreen> createState() => testScreenState();
}

class testScreenState extends State<testScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width - 165,
            child: CupertinoButton(
              onPressed: () async {
                if(await isKakaoTalkInstalled()){
                  print("true");
                  try{
                    await UserApi.instance.loginWithKakaoTalk();
                    print("카카오톡 로그인 성공!!");
                  }catch(error){
                    print("카카오톡 로그인 실패 : $error");
                  }
                  try{
                    // await UserApi.instance.loginWithKakaoAccount();
                    print("카카오 계정으로 로그인 완료");
                  }catch(error){
                    print("카카오 계정 로그인 실패 : $error");
                  }
                }else{
                  print("false");
                  try{
                    // AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
                    await UserApi.instance.loginWithKakaoAccount();
                    // await UserㅏApi.instance.loginWithKakaoTalk();
                    // await UserApi.instance.loginWithKakaoAccount();
                    print("카카오 계정으로 로그인 성공");
                  } catch (error) {
                    print("카카오 계정 로그인 실패....$error");
                  }
                }
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
      )
    );
  }
}
