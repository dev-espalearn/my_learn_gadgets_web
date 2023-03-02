import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/cart_item.dart';
import '../../shopping_cart/get_controllers/shopping_cart_get_controller.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({Key? key}) : super(key: key);
  ShoppingCartGetController getController =
      Get.put(ShoppingCartGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Out'),
        ),
        body: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: TextStyle(fontSize: 20)),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.users)
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection(AppString.shoppingCart)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<CartItem> products = snapshot.data!.docs
                              .map((e) => CartItem.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                              .toList();
                          return Text(
                              products.isNotEmpty
                                  ? "Rs. ${products.map((e) => e.product.discountedPrice * e.quantity).reduce((value, element) => value + element)}"
                                  : "Rs. 0.0",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500));
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ]),
          ],
        ));
  }
}
