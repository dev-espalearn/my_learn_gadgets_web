import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';

import '../../../models/cart_item.dart';

class ShoppingCartGetController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  void getCartItems() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppString.shoppingCart)
        .get()
        .then((value) {
      cartItems.clear();
      for (var element in value.docs) {
        cartItems.add(CartItem.fromJson(element.data()));
      }
    });
  }

  void incrementQuantity(CartItem cartItem) {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppString.shoppingCart)
        .doc(cartItem.product.id)
        .update({
      'quantity': cartItem.quantity + 1,
    });
  }

  void decrementQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      FirebaseFirestore.instance
          .collection(AppString.users)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(AppString.shoppingCart)
          .doc(cartItem.product.id)
          .update({
        'quantity': cartItem.quantity - 1,
      });
    } else {
      FirebaseFirestore.instance
          .collection(AppString.users)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(AppString.shoppingCart)
          .doc(cartItem.product.id)
          .delete();
    }
  }

  void deleteAllItemsFromShoppingCart() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection(AppString.shoppingCart)
        .get()
        .then((value) {
      for (var element in value.docs) {
        FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(AppString.shoppingCart)
            .doc(element.id)
            .delete();
      }
    });
  }

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }
}
