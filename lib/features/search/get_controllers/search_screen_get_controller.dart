import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';

import '../../../models/product_model.dart';

class SearchScreenGetController extends GetxController {
  final String searchQuery;

  SearchScreenGetController({required this.searchQuery});

  RxList<ProductModel> products = <ProductModel>[].obs;

  void search() {
    FirebaseFirestore.instance
        .collection(AppString.products)
        .where(AppString.name, arrayContains: searchQuery)
        .get()
        .then((value) {
      products.clear();
      products.value =
          value.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
  }

  @override
  void onInit() {
    search();
    super.onInit();
  }
}
