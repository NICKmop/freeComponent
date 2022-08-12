import 'package:flutter/material.dart';
import 'package:freecomponent/constants/colors.constants.dart';
import 'package:freecomponent/controller/HomeController.dart';
import 'package:freecomponent/screens/test.screen.dart';
import 'package:get/get.dart';

import '../controller/NavigationController.dart';
import 'crawling.screen.dart';

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  State<mainScreen> createState() => mainScreenState();
}

class mainScreenState extends State<mainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(NavigationController());
    Get.put(HomeController());
    final navigationController = Get.find<NavigationController>();

    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: AppColors.primary,
      //   unselectedItemColor: AppColors.grey,
      //   currentIndex: navigationController.currentBottomMenuIndex.value,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.ac_unit),
      //       label: "크롤링 테스트"
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_box),
      //       label: "next Page"
      //     )
      //   ],
      // ),
      bottomNavigationBar: Obx(
              () => Offstage(
                offstage:HomeController.to.hideBottomMenu.value,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    BottomNavigationBar(
                      showUnselectedLabels: true,
                      showSelectedLabels: true,
                      selectedLabelStyle: const TextStyle(color: Colors.red),
                      selectedItemColor: AppColors.primary,
                      unselectedItemColor: AppColors.grey,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.ac_unit),
                          label: "크롤링페이지",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.abc_rounded),
                          label: "firebases데이터 테스트"
                        )
                      ]
                    )
                  ],
                ),
              )
      ),
      body: Obx(
          () => IndexedStack(
            index: navigationController.currentBottomMenuIndex.value,
            children: const[
              testScreen(),
              crawlingScreen(),
            ],
          )
      ),
    );
  }
}
