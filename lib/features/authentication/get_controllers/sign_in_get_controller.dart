import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';

import '../../admin_dashboard/ui/admin_dashboard_page.dart';

class SignInGetController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool showLoader = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      showLoader.value = true;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        showLoader.value = false;
        Get.offAll(() => HomeScreen());
      }).catchError((e) {
        showLoader.value = false;
        Get.snackbar("Error", e.toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      });
      showLoader.value = false;
    }
  }

  Future<void> signInAsAdmin() async {
    if (formKey.currentState!.validate()) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: AppString.emailForTemporaryLogin,
          password: AppString.passwordForTemporaryLogin)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection(AppString.admins)
            .doc(emailController.text)
            .get()
            .then((value) async {
          if (value.exists) {
            showLoader.value = true;
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
                .then((value) {
              showLoader.value = false;
              Get.offAll(() => const AdminDashboardPage());
            }).catchError((e) {
              showLoader.value = false;
              Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
            });
            showLoader.value = false;
          } else {
            Get.snackbar("Error", "You are not an admin",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        });
      });
    }
  }
}
