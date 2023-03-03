import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';

import '../../../core/app_string.dart';
import '../../../models/cart_item.dart';
import '../../shopping_cart/get_controllers/shopping_cart_get_controller.dart';
import '../get_controllers/check_out_get_controller.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({Key? key}) : super(key: key);
  ShoppingCartGetController getController =
  Get.put(ShoppingCartGetController());

  CheckOutGetController checkOutGetController = Get.put(CheckOutGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Out'),
        ),
        body: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  .map((e) =>
                                  CartItem.fromJson(
                                      jsonDecode(jsonEncode(e.data()))))
                                  .toList();
                              return Text(
                                  products.isNotEmpty
                                      ? "Rs. ${products.map((e) =>
                                  e.product.discountedPrice * e.quantity)
                                      .reduce((value, element) =>
                                  value + element)}"
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
                Divider(
                  thickness: 2,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 20),
/*TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();*/
              TextFormField(
                controller: checkOutGetController.addressLine1Controller,
                decoration: InputDecoration(
                  labelText: "Address Line 1",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: checkOutGetController.addressLine2Controller,
                decoration: InputDecoration(
                  labelText: "Address Line 2",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: checkOutGetController.cityController,
                        decoration: InputDecoration(
                          labelText: "City",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: checkOutGetController.stateController,
                        decoration: InputDecoration(
                          labelText: "State",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: checkOutGetController.pinCodeController,
                  decoration: InputDecoration(
                    labelText: "Pin Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
