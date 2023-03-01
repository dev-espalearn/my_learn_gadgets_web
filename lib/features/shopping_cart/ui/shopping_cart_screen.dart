import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/models/cart_item.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_string.dart';
import '../get_controllers/shopping_cart_get_controller.dart';

class ShoppingCartScreen extends StatelessWidget {
  ShoppingCartScreen({Key? key}) : super(key: key);

  ShoppingCartGetController shoppingCartGetController =
      Get.put(ShoppingCartGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(elevation: 0,
            title: const Text(
              'Shopping Cart',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_forever,
                    color: AppColors.tertiaryColor,
                  ))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Neumorphic(
                  style: const NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    color: Colors.white,
                    depth: 2,
                    intensity: 0.8,
                  ),
                  child: ListTile(
                    title: const Text(
                      "Total:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection(AppString.users)
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection(AppString.shoppingCart)
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<CartItem> cartItems = snapshot.data!.docs
                              .map((e) => CartItem.fromJson(
                                  jsonDecode(jsonEncode(e.data()))))
                              .toList();
                          if (snapshot.hasData) {
                            return Text(
                                cartItems.isNotEmpty
                                    ? cartItems
                                        .map((e) => e.product.discountedPrice)
                                        .toList()
                                        .reduce(
                                            (value, element) => value + element)
                                        .toString()
                                    : "0.0",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppColors.primaryColor,
                                    fontStyle: FontStyle.italic));
                          }
                          return Container();
                        }),
                  ),
                ),
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
                        List<CartItem> cartItems = snapshot.data!.docs
                            .map((e) => CartItem.fromJson(
                                jsonDecode(jsonEncode(e.data()))))
                            .toList();
                        return ListView.builder(
                            itemBuilder: (context, index) {
                              CartItem cartItem = cartItems[index];
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
                                                cartItem.product.image)),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                cartItem.product.name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              AutoSizeText(
                                                cartItem.product.description,
                                                maxLines: 4,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '\$ ${cartItem.product.discountedPrice}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            NeumorphicButton(
                                              onPressed: () {},
                                              style: const NeumorphicStyle(
                                                shape: NeumorphicShape.concave,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color: Colors.white,
                                                depth: 2,
                                                intensity: 1,
                                              ),
                                              child: const Icon(Icons.add),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            NeumorphicButton(
                                              onPressed: () {},
                                              style: const NeumorphicStyle(
                                                shape: NeumorphicShape.concave,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color: Colors.white,
                                                depth: 2,
                                                intensity: 1,
                                              ),
                                              child: const Icon(Icons.remove),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Neumorphic(
                                          style: const NeumorphicStyle(
                                            shape: NeumorphicShape.flat,
                                            color: Colors.white,
                                            depth: -1,
                                            intensity: 1,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '× ${cartItem.quantity}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount:
                                shoppingCartGetController.cartItems.length);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Proceed to Checkout >>",
                    style: TextStyle(
                      color: AppColors.tertiaryColor.shade500,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
