import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';
import 'package:my_learn_gadgets_web/helpers/string_helper.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';

class SignUpScreenGetUpController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  RxBool newsletter = true.obs;

  RxBool privacyPolicy = false.obs;

  RxBool passwordVisible = false.obs;

  RxBool showLoader = false.obs;

  Future<void> signUpUsingEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      showLoader.value = true;

      if (passwordController.text == passwordConfirmController.text) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: AppString.emailForTemporaryLogin,
                password: AppString.passwordForTemporaryLogin)
            .then((value) async {
          await FirebaseFirestore.instance
              .collection(AppString.users)
              .doc(emailController.text.trim())
              .get()
              .then((value) async {
            if (!value.exists) {
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text)
                  .catchError((error) {
                Get.snackbar("Error", error.toString(),
                    backgroundColor: Colors.red, colorText: Colors.white);
              }).then((value) async {
                await FirebaseFirestore.instance
                    .collection(AppString.users)
                    .doc(value.user!.email)
                    .set(UserModel(
                            firstName: firstNameController.text
                                .trim()
                                .firstLetterOfEveryWordToCapital(),
                            lastName: lastNameController.text
                                .trim()
                                .firstLetterOfEveryWordToCapital(),
                            email: emailController.text.trim())
                        .toJson())
                    .then((value) {
                  Get.snackbar("Success", "Account created successfully");
                  Get.offAll(() => HomeScreen());
                });
                await FirebaseFirestore.instance
                    .collection(AppString.users)
                    .doc(value.user!.email)
                    .update({AppString.newsletter: newsletter.value});
              });
            } else {
              Get.snackbar("Error", "Email already exists");
              FirebaseAuth.instance.signOut();
            }
          });
        });
      } else {
        Get.snackbar("Error", "Password does not match");
      }
      showLoader.value = false;
    }
  }
}
