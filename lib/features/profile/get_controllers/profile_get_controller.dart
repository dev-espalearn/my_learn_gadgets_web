import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';

class ProfileGetController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;
  RxBool newsLetter = false.obs;
  Rx<File?> profileImage = null.obs;

  void loadCurrentUser() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      currentUser.value = UserModel.fromJson(value.data()!);
      newsLetter.value = value.data()!['newsLetter'];
    });
  }

  void toggleNewsletter() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      bool newsLetter = value.data()![AppString.newsletter];
      FirebaseFirestore.instance
          .collection(AppString.users)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        AppString.newsletter: !newsLetter,
      });
    });
  }

  Map<IconData, String> options = {
    Icons.location_history: "Track orders",
    Icons.lock: "Login and Security",
    Icons.shopping_cart: "My Cart",
    Icons.favorite: "My Wishlist",
  };

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }
}
