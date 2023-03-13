import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';
import '../../login_and_security/ui/change_password_screen.dart';
import '../../shopping_cart/ui/shopping_cart_screen.dart';
import '../../user_order_history/ui/user_order_history_screen.dart';
import '../../user_track_order/ui/user_track_order_screen.dart';
import '../../wish_list/ui/wish_list_screen.dart';

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

  // Map<IconData, String> options = {
  //   Icons.location_history: "Track orders",
  //   Icons.lock: "Login and Security",
  //   Icons.shopping_cart: "My Cart",
  //   Icons.favorite: "My Wishlist",
  //   Icons.card_travel: "Order History",
  //   Icons.person: "My Details",
  // };

  Map<String, String> options = {
    'assets/images/track.png': "Track orders",
    'assets/images/login.png' : "Login and Security",
    'assets/images/cart.png' : "My Cart",
    'assets/images/wishlist.png' : "My Wishlist",
    'assets/images/history.png' : "Order History",
    'assets/images/details.png' : "My Details",
  };

  Map<int, Widget?> routing = {
    0: UserTrackOrderScreen(),
    1: const ChangePasswordScreen(),
    2: ShoppingCartScreen(),
    3: const WishListScreen(),
    4: UserOrderHistoryScreen(),
  };

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }
}
