import 'package:my_learn_gadgets_web/models/cart_item.dart';
import 'package:my_learn_gadgets_web/models/progress_model.dart';
import 'package:my_learn_gadgets_web/models/user_model.dart';

class OrderModel {
  String id;
  UserModel customer;
  DateTime orderDate;
  ProgressModel progress;
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
      progress: ProgressModel.fromJson(json['progress']),
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
      'progress': progress.toJson(),
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
      'address': address,
      'phoneNumber': phoneNumber,
      'estimatedDeliveryDate': estimatedDeliveryDate.toIso8601String(),
    };
  }

  factory OrderModel.copyWith(OrderModel orderModel,
      {String? id,
      UserModel? customer,
      DateTime? orderDate,
      ProgressModel? progress,
      List<CartItem>? products,
      String? address,
      String? phoneNumber,
      DateTime? estimatedDeliveryDate}) {
    return OrderModel(
      id: id ?? orderModel.id,
      customer: customer ?? orderModel.customer,
      orderDate: orderDate ?? orderModel.orderDate,
      progress: progress ?? orderModel.progress,
      products: products ?? orderModel.products,
      address: address ?? orderModel.address,
      phoneNumber: phoneNumber ?? orderModel.phoneNumber,
      estimatedDeliveryDate:
          estimatedDeliveryDate ?? orderModel.estimatedDeliveryDate,
    );
  }
}
