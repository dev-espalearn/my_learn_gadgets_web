import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/product_model.dart';

class AllProductGetController extends GetxController {
  Future<void> addToFeaturedProduct(ProductModel product) async {
    await FirebaseFirestore.instance
        .collection(AppString.products)
        .doc(product.id)
        .get()
        .then((value) async {
      ProductModel productModel =
          ProductModel.fromJson(jsonDecode(jsonEncode(value.data())));

      productModel = ProductModel.copyWith(productModel, featured: true);

      await FirebaseFirestore.instance
          .collection(AppString.products)
          .doc(product.id)
          .set(productModel.toJson());
    });
  }
}
