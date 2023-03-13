import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/progress_model.dart';
import '../../../models/user_model.dart';

class UserTrackOrderGetController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;
  RxDouble percentage = 0.0.obs;

  void loadCurrentUser() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      currentUser.value = UserModel.fromJson(value.data()!);
    });
  }

  void setPercentage(ProgressModel progressModel) {
    if (progressModel.id == 0) {
      percentage.value = 0.25;
    }
    if (progressModel.id == 1) {
      percentage.value = 0.5;
    }
    if (progressModel.id == 2) {
      percentage.value = 0.75;
    }
    if (progressModel.id == 3) {
      percentage.value = 1.0;
    }
  }

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }
}
