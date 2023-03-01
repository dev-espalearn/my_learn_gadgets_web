import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/features/home/ui/home_screen.dart';

import '../../admin_dashboard/ui/admin_dashboard_page.dart';

class SplashPageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  /*Rx<User?> currentUser = FirebaseAuth.instance.currentUser.obs;*/

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController.forward(from: 0).then((value) async {
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.email !=
              AppString.emailForTemporaryLogin) {
        await FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((value) async {
          if (value.exists) {
            Get.offAll(() => HomeScreen());
          } else {
            await FirebaseFirestore.instance
                .collection(AppString.admins)
                .doc(FirebaseAuth.instance.currentUser!.email)
                .get()
                .then((value) {
              if (value.exists) {
                Get.offAll(() => const AdminDashboardPage());
              }
            });
          }
        });
      } else {
        await signInWithDemoCredentials().then((value) {
          Get.offAll(() => HomeScreen());
        });
      }
      /*addDemoProduct();*/
    });

    super.onInit();
  }

  Future<void> signInWithDemoCredentials() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AppString.emailForTemporaryLogin,
          password: AppString.passwordForTemporaryLogin);
    }
  }

/*void addDemoProduct() {
    Uuid uuid = Uuid();
    String id = uuid.v4();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: AppString.emailForTemporaryLogin,
      password: AppString.passwordForTemporaryLogin,
    )
        .then((value) {
      FirebaseFirestore.instance.collection(AppString.products).doc(id).set({
        'id': id,
        'name': 'Demo Product',
        'description': 'Demo Product Description',
        'image':
            "https://images.esellerpro.com/2131/I/161/741/lrgscaleDSC_0001.JPG",
        'secondaryImages': [
          'https://images.esellerpro.com/2131/I/161/741/lrgscaleDSC_0001.JPG',
          'https://brain-images-ssl.cdn.dixons.com/1/5/10180951/u_10180951.jpg'
        ],
        'discountedPrice': 299.50,
        'originalPrice': 1999.50,
        'specification': {
          "Ram": "8GB",
          "SSD": "256GB",
        },
        'featured': true,
        'banner': true,
        'category': "Laptops & Notebooks",
        'quantityLeft': 50,
      });
    });
  }*/
}
