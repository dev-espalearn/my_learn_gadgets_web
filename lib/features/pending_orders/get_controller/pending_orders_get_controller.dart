import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../core/app_string.dart';
import '../../../models/progress_model.dart';

class PendingOrdersGetController extends GetxController {
  RxList<ProgressModel> progress = <ProgressModel>[].obs;
  Rx<ProgressModel> selectedProgressStatus = ProgressModel.empty().obs;

  void fetchProgressStatus() {
    FirebaseFirestore.instance
        .collection(AppString.progress)
        .get()
        .then((value) {
      for (var element in value.docs) {
        progress.add(ProgressModel.fromJson(element.data()));
      }
      selectedProgressStatus.value = progress.first;
    });
  }

  @override
  void onInit() {
    fetchProgressStatus();
    super.onInit();
  }
}
