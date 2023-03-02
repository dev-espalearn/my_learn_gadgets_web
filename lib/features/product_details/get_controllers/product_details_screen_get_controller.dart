import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/models/cart_item.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_string.dart';
import '../../../models/product_model.dart';
import '../../../models/review_model.dart';
import '../../../models/user_model.dart';

class ProductDetailsScreenGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final ProductModel product;

  RxString selectedImageLink = ''.obs;

  ProductDetailsScreenGetController(this.product);

  TextEditingController reviewTitleController = TextEditingController();
  TextEditingController reviewDescriptionController = TextEditingController();
  double ratings = 0.0;

  @override
  void onInit() {
    selectedImageLink.value = product.secondaryImages[0];
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  void submitReview() {
    print("Current User Email: ${FirebaseAuth.instance.currentUser!.email}");
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      UserModel user = UserModel.fromJson(jsonDecode(jsonEncode(value.data())));

      String id = const Uuid().v4();
      ReviewModel review = ReviewModel(
          id: id,
          productId: product.id,
          postedBy: user,
          title: reviewTitleController.text,
          description: reviewDescriptionController.text,
          rating: ratings,
          postedOn: DateTime.now());
      FirebaseFirestore.instance
          .collection(AppString.products)
          .doc(product.id)
          .collection(AppString.reviews)
          .doc(id)
          .set(review.toJson())
          .then((value) {
        Get.back();
        Get.snackbar('Success', 'Review posted successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      });
    });
  }

  void addToShoppingCart() {
    CartItem cartItem = CartItem(product: product, quantity: 1);
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppString.shoppingCart)
        .doc(product.id)
        .set(cartItem.toJson())
        .then((value) {
      Get.snackbar('Success', 'Product added to shopping cart',
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }

  void addToWishList() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppString.wishList)
        .doc(product.id)
        .set(product.toJson())
        .then((value) {
      Get.snackbar('Success', 'Product added to wish list',
          backgroundColor: Colors.green, colorText: Colors.white);
    });
  }
}
