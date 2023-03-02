import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';

import '../../../models/cart_item.dart';
import '../get_controllers/shopping_cart_get_controller.dart';

class ShoppingCartScreen extends StatelessWidget {
  ShoppingCartScreen({Key? key}) : super(key: key);

  ShoppingCartGetController getController =
      Get.put(ShoppingCartGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(
            elevation: 0,
            leading: Icon(Icons.shopping_cart),
            title: const Text(
              'My Cart',
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 8),
            child: Column(
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
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 2,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
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
                          return ListView.builder(
                              itemBuilder: (context, index) {
                                CartItem product = products[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4),
                                  child: Neumorphic(
                                    style: const NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      color: Colors.white,
                                      depth: 1,
                                      intensity: 1,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: Get.width / 5,
                                              child: Image.network(
                                                  product.product.image)),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  product.product.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  product.product.description,
                                                  maxLines: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'Rs. ${product.product.discountedPrice}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.delete),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              NeumorphicButton(
                                                onPressed: () {
                                                  getController
                                                      .incrementQuantity(
                                                          product);
                                                },
                                                style: const NeumorphicStyle(
                                                  shape: NeumorphicShape.flat,
                                                  boxShape: NeumorphicBoxShape
                                                      .circle(),
                                                  color: Colors.white,
                                                  depth: 1,
                                                  intensity: 0.6,
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_drop_up,
                                                  size: 20,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              NeumorphicButton(
                                                onPressed: () {
                                                  getController
                                                      .decrementQuantity(
                                                          product);
                                                },
                                                style: const NeumorphicStyle(
                                                  shape: NeumorphicShape.flat,
                                                  boxShape: NeumorphicBoxShape
                                                      .circle(),
                                                  color: Colors.white,
                                                  depth: 1,
                                                  intensity: 0.6,
                                                ),
                                                child: const Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Neumorphic(
                                            style: const NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              color: Colors.white,
                                              depth: -1,
                                              intensity: 1,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8.0),
                                              child: Text(
                                                  product.quantity.toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: products.length);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //proceed to checkout
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NeumorphicButton(
                  onPressed: () {},
                  style: const NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    color: Colors.white,
                    depth: 1,
                    intensity: 1,
                  ),
                  child: Text(
                    'Proceed to Checkout >>',
                    style: TextStyle(
                      color: AppColors.tertiaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],),
        ),
      ),
    );
  }
}
