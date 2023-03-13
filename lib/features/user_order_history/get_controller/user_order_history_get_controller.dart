import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/app_string.dart';
import '../../../models/user_model.dart';

class UserOrderHistoryGetController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;

  void loadCurrentUser() {
    FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      currentUser.value = UserModel.fromJson(value.data()!);
    });
  }

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }
}
