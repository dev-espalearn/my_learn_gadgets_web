import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/product_model.dart';

class ProductDetailsScreenGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final ProductModel product;

  RxString selectedImageLink = 'assets/images/OIP.jpeg'.obs;

  ProductDetailsScreenGetController(this.product);

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }
}
