import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';

import '../../admin_dashboard/ui/admin_dashboard_page.dart';

class SplashPageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController.forward(from: 0).then((value) async {
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.email !=
              AppString.emailForTemporaryLogin) {
        await FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((value) async {
          if (value.exists) {
            Get.offAll(() => HomeScreen());
          } else {
            await FirebaseFirestore.instance
                .collection(AppString.admins)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .get()
                .then((value) {
              if (value.exists) {
                Get.offAll(() => const AdminDashboardPage());
              }
            });
          }
        });
      } else {
        await signInWithDemoCredentials().then((value) {
          Get.offAll(() => HomeScreen());
        });
      }
      
    });

    super.onInit();
  }

  Future<void> signInWithDemoCredentials() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AppString.emailForTemporaryLogin,
          password: AppString.passwordForTemporaryLogin);
    }
  }


}
