import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';

import '../../../models/product_model.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(elevation: 0,
            title: const Text(
              'Wish List',
            ),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Divider(
                color: AppColors.primaryColor,
                thickness: 2,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(AppString.users)
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection(AppString.wishList)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> products = snapshot.data!.docs
                          .map((e) => ProductModel.fromJson(
                              jsonDecode(jsonEncode(e.data()))))
                          .toList();
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            ProductModel product = products[index];
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
                                          child: Image.asset(product.image)),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              product.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            AutoSizeText(
                                              product.description,
                                              maxLines: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Rs. ${product.discountedPrice}',
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
            ],
          ),
        ),
      ),
    );
  }
}
