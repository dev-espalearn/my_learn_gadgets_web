import 'package:my_learn_gadgets_web/models/cart_item.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';

class OrderModel {
  String id;
  UserModel customer;
  DateTime orderDate;
  int progress; // 0: pending, 1: processing, 2: shipped, 3: delivered
  List<CartItem> products;
  String address;
  String phoneNumber;
  DateTime estimatedDeliveryDate;

  OrderModel({
    required this.id,
    required this.customer,
    required this.orderDate,
    required this.progress,
    required this.products,
    required this.address,
    required this.phoneNumber,
    required this.estimatedDeliveryDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      customer: UserModel.fromJson(json['customer']),
      orderDate: DateTime.parse(json['orderDate']),
      progress: json['progress'],
      products: List<CartItem>.from(
          json['products'].map((x) => CartItem.fromJson(x))),
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      estimatedDeliveryDate: DateTime.parse(json['estimatedDeliveryDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'orderDate': orderDate.toIso8601String(),
      'progress': progress,
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
      'address': address,
      'phoneNumber': phoneNumber,
      'estimatedDeliveryDate': estimatedDeliveryDate.toIso8601String(),
    };
  }
}
