import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';

class SplashPageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;

  @override
  void onInit() {
    signInWithDemoCredentials();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController.forward(from: 0).then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAll(() => HomeScreen(), transition: Transition.cupertino);
      });
    });
    super.onInit();
  }

  Future<void> signInWithDemoCredentials() async {
    if (FirebaseAuth.instance.currentUser == null) {
      currentUser.value = null;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: AppString.emailForTemporaryLogin,
              password: AppString.passwordForTemporaryLogin)
          .then((value) {});
    } else {
      currentUser.value = FirebaseAuth.instance.currentUser;
    }
    addAdmin();
  }

  void addAdmin() {
    FirebaseFirestore.instance
        .collection(AppString.admins)
        .doc("admin@spsmart.com")
        .set(UserModel(
                firstName: 'Admin',
                lastName: 'Admin',
                email: 'admin@spsmart.com')
            .toJson());
  }
}
