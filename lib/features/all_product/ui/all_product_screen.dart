import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/pending_orders/ui/pending_order_detail.dart';
import 'package:my_learn_gadgets_web/helpers/date_time_helpers.dart';

import '../../../models/product_model.dart';
import '../get_controller/all_product_get_controller.dart';



class AllProductScreen extends StatelessWidget {
  AllProductScreen({Key? key}) : super(key: key);

  AllProductGetController getController =
  Get.put(AllProductGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
          appBar: AppBar(
            elevation: 0,
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              'All Products',
            ),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: 8),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(AppString.products)
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
                                            child: Image(
                                              image: NetworkImage(


                                                    product
                                                    .image,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                  'Product Id: ${product.id}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Product name: ${product.name}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Description: ${product.description}',
                                                  maxLines: 4,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Original Price: \$${product.originalPrice}' ,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Discounted Price: \$${product.discountedPrice}',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Category: ${product.category}',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AutoSizeText(
                                                  'Quantity left: ${product.quantityLeft}',
                                                ),

                                              ],
                                            ),
                                          ),
                                          NeumorphicButton(
                                            style: const NeumorphicStyle(
                                              color: Colors.white,
                                              boxShape: NeumorphicBoxShape.stadium(),
                                              depth: 3,
                                              intensity: 0.6,
                                            ),
                                            onPressed: () async {
                                              getController.addToFeaturedProduct(product);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: AppColors.tertiaryColor.shade700,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'Add to featured product list',
                                                  style: TextStyle(
                                                      color: AppColors.tertiaryColor.shade700),
                                                ),
                                              ],
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
        ),
      ),
    );
  }
}
