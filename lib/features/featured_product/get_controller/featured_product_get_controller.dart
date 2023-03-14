import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/product_model.dart';

class FeaturedProductGetController extends GetxController {

  Future<void> removeFromFeaturedProduct(ProductModel product) async{
    await FirebaseFirestore.instance
        .collection(AppString.products)
        .doc(product.id)
        .get()
        .then((value) async{
      ProductModel productModel =
      ProductModel.fromJson(jsonDecode(jsonEncode(value.data())));

      productModel = ProductModel.copyWith(productModel,
          featured: false);

      await FirebaseFirestore.instance
          .collection(AppString.products)
          .doc(product.id)
          .set(productModel.toJson());
    });
  }


}