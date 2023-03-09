import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      selectedProgressStatus.value = progress.first;
    });
  }

  Future<void> addToOrderHistory(OrderModel selectedOrder) async{
    await FirebaseFirestore.instance
        .collection(AppString.ordersHistory)
        .doc(selectedOrder.id)
        .set(selectedOrder.toJson()).then((value) {
      removeFromOrders(selectedOrder);
    });
  }

  Future<void> removeFromOrders(OrderModel selectedOrder) async{
    await FirebaseFirestore.instance
        .collection(AppString.orders)
        .doc(selectedOrder.id)
        .delete();
  }

  @override
  void onInit() {
    fetchProgressStatus();
    super.onInit();
  }
}
