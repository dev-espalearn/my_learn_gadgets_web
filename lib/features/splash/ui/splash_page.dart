import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/features/splash/get_controllers/splash_page_get_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  SplashPageGetController splashPageGetController =
      Get.put(SplashPageGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: Get.width * 0.8,
          child: FadeTransition(
              opacity: splashPageGetController.animationController,
              child: SizeTransition(
                  sizeFactor: splashPageGetController.animationController,
                  child: Image.asset("assets/images/My learn gadgets.png"))),
        ),
      ),
    ));
  }
}
