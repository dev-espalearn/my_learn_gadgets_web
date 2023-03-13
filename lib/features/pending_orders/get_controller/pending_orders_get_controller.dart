import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/order_model.dart';
import '../../../models/progress_model.dart';

class PendingOrdersGetController extends GetxController {
  RxList<ProgressModel> progress = <ProgressModel>[].obs;
  Rx<ProgressModel> selectedProgressStatus = ProgressModel.empty().obs;

  void fetchProgressStatus() {
    FirebaseFirestore.instance
        .collection(AppString.orderProgressIndicators)
        .get()
        .then((value) {
      for (var element in value.docs) {
        progress.add(ProgressModel.fromJson(element.data()));
      }
     // selectedProgressStatus.value = progress.first;
    });
  }

  Future<void> addToOrderHistory(OrderModel selectedOrder) async {
    await FirebaseFirestore.instance
        .collection(AppString.ordersHistory)
        .doc(selectedOrder.id)
        .set(selectedOrder.toJson())
        .then((value) {
      addToUserOrderHistory(selectedOrder);
    });
  }

  Future<void> addToUserOrderHistory(OrderModel selectedOrder) async {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(selectedOrder.customer.email)
        .collection(AppString.ordersHistory)
        .doc(selectedOrder.id)
        .set(selectedOrder.toJson())
        .then((value) {
      removeFromOrders(selectedOrder);
    });
  }

  Future<void> removeFromOrders(OrderModel selectedOrder) async {
    await FirebaseFirestore.instance
        .collection(AppString.orders)
        .doc(selectedOrder.id)
        .delete()
        .then((value) {});
  }

  Future<void> changeProgressStatus(OrderModel selectedOrder) async {
    FirebaseFirestore.instance
        .collection(AppString.orders)
        .doc(selectedOrder.id)
        .get()
        .then((value) {
      OrderModel orderModel =
          OrderModel.fromJson(jsonDecode(jsonEncode(value.data())));
      orderModel = OrderModel.copyWith(orderModel,
          progress: selectedProgressStatus.value);
      FirebaseFirestore.instance
          .collection(AppString.orders)
          .doc(selectedOrder.id)
          .set(orderModel.toJson());
    }).then((value) {
      FirebaseFirestore.instance
          .collection(AppString.users)
          .doc(selectedOrder.customer.email)
          .collection(AppString.placedOrders)
          .doc(selectedOrder.id)
          .get()
          .then((value) {
        OrderModel orderModel =
            OrderModel.fromJson(jsonDecode(jsonEncode(value.data())));
        orderModel = OrderModel.copyWith(orderModel,
            progress: selectedProgressStatus.value);
        FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(selectedOrder.customer.email)
            .collection(AppString.placedOrders)
            .doc(selectedOrder.id)
            .set(orderModel.toJson());
      });
    });
  }

  @override
  void onInit() {
    fetchProgressStatus();
    super.onInit();
  }
}
