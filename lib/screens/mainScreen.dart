import 'package:flutter/material.dart';
import 'package:freecomponent/constants/colors.constants.dart';
import 'package:freecomponent/controller/HomeController.dart';
import 'package:freecomponent/screens/freeComponent_viewpage.dart';
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
    print(navigationController.currentBottomMenuIndex);
    return Scaffold(
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
                      items: [
                        BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/bottom-menu-my.png",
                            height: 30,
                            color:
                            navigationController.currentBottomMenuIndex.value == 0
                                ? AppColors.primary
                                : AppColors.grey,
                          ),
                          label: "firebases데이터 테스트",
                        ),
                        BottomNavigationBarItem(
                            icon: Image.asset(
                              "assets/images/bottom-menu-my.png",
                              height: 30,
                              color:
                              navigationController.currentBottomMenuIndex.value == 1
                                  ? AppColors.primary
                                  : AppColors.grey,
                            ),
                          label: "크롤링페이지"
                        )
                      ],
                      onTap: (index) {
                        navigationController.currentBottomMenuIndex.value = index;
                        setState(() {});
                      },
                    )
                  ],
                ),
              )
      ),
      body: Obx(
          () => IndexedStack(
            index: navigationController.currentBottomMenuIndex.value,
            children: const[
              freeComponent_viewpage(),
              crawlingScreen(),
            ],
          )
      ),
    );
  }
}
