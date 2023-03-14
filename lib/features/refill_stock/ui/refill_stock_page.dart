import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/models/product_model.dart';

import '../../../core/app_colors.dart';

class RefillStockPage extends StatelessWidget {
  const RefillStockPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor.shade50.withOpacity(0.1),
        appBar: AppBar(
          title: const Text('Refill Stock'),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(AppString.products)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProductModel> products = snapshot.data!.docs
                    .map((e) =>
                        ProductModel.fromJson(jsonDecode(jsonEncode(e.data()))))
                    .toList();
                List<TextEditingController> priceControllers = List.generate(
                    products.length,
                    (index) => TextEditingController(
                        text: products[index].discountedPrice.toString()));
                List<TextEditingController> quantityControllers = List.generate(
                    products.length,
                    (index) => TextEditingController(
                        text: products[index].quantityLeft.toString()));
                return ListView.builder(
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Neumorphic(
                          style: const NeumorphicStyle(
                            depth: 1,
                            intensity: 0.5,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Image.network(
                                  product.image,
                                  width: Get.width * 0.1,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 5,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: priceControllers[index],
                                        decoration: const InputDecoration(
                                          labelText: 'Price',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: quantityControllers[index],
                                        decoration: const InputDecoration(
                                          labelText: 'Quantity',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                NeumorphicButton(
                                  style: const NeumorphicStyle(
                                    depth: 2,
                                    intensity: 0.5,
                                    color: Colors.white,
                                    shape: NeumorphicShape.convex,
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection(AppString.products)
                                        .doc(product.id)
                                        .update({
                                      AppString.discountedPrice: double.parse(
                                          priceControllers[index].text),
                                      AppString.quantityLeft: int.parse(
                                          quantityControllers[index].text),
                                    });
                                  },
                                  child: const Text('Update'),
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
    );
  }
}
