import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../core/app_string.dart';
import '../../../models/cart_item.dart';
import '../../../models/order_model.dart';
import '../../../models/progress_model.dart';
import '../../../models/user_model.dart';
import '../../home/ui/home_screen.dart';
import '../../shopping_cart/get_controllers/shopping_cart_get_controller.dart';

class CheckOutGetController extends GetxController {
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool isLoading = false.obs;
  Uuid uuid = const Uuid();
  RxString cardNumber = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cardHolderName = ''.obs;
  RxString cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  RxBool useGlassMorphism = true.obs;
  RxBool useBackgroundImage = false.obs;
  OutlineInputBorder? border;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ShoppingCartGetController shoppingCartGetController =
      Get.find<ShoppingCartGetController>();

  RxList<CartItem> products = <CartItem>[].obs;

  Rx<UserModel> userModel = UserModel.empty().obs;

  @override
  void onInit() {
    loadCustomer();
    super.onInit();
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  Future<void> loadCustomer() async {
    await FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(jsonDecode(jsonEncode(value.data()))).obs;
    });
  }

  Future<void> pay() async {
    if (addressLine1Controller.text.isEmpty) {
      Get.snackbar('Error', 'Please enter address details',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter city name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (stateController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter state name',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (pinCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter pin code number',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter phone number',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    String orderId = uuid.v4();
    OrderModel orderModel = OrderModel(
      id: orderId,
      customer: userModel.value,
      orderDate: DateTime.now(),
      progress: ProgressModel.empty(),
      products: products,
      address: '${addressLine1Controller.text},${addressLine2Controller.text},${cityController.text},${stateController.text},${pinCodeController.text}',
      phoneNumber: phoneController.text,
      estimatedDeliveryDate: DateTime.now().add(const Duration(days: 10)),

    );

    await FirebaseFirestore.instance
        .collection(AppString.orders)
        .doc(orderId)
        .set(orderModel.toJson())
    .then((value) {

        FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection(AppString.placedOrders)
            .doc(orderModel.id)
            .set(orderModel.toJson());
      isLoading.value = false;
      Get.snackbar('Congratulations!', 'Your order has been placed',
          backgroundColor: Colors.green, colorText: Colors.white);

      FirebaseFirestore.instance
          .collection(AppString.users)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection(AppString.shoppingCart)
          .get()
          .then((value) {

        for (var element in value.docs) {
          FirebaseFirestore.instance
              .collection(AppString.users)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection(AppString.shoppingCart)
              .doc(element.id)
              .delete();

        }
      });


    }).then((value) {
      Get.offAll(transition: Transition.cupertino, () => HomeScreen());
    });

  }

}
