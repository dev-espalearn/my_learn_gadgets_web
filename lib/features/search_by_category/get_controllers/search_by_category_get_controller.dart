import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/product_model.dart';

class SearchByCategoryGetController extends GetxController {
  final String searchQuery;

  SearchByCategoryGetController({required this.searchQuery});

  RxList<ProductModel> products = <ProductModel>[].obs;

  void search() {
    FirebaseFirestore.instance
        .collection(AppString.products)
        .where(AppString.category, isEqualTo: searchQuery)
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
