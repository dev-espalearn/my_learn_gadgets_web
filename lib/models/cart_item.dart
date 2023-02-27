import 'package:my_learn_gadgets_web/models/product_model.dart';

class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  //from json
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
