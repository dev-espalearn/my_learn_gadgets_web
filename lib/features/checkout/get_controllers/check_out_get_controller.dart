import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CheckOutGetController extends GetxController{
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
  RxBool useGlassMorphism = false.obs;
  RxBool useBackgroundImage = false.obs;
  OutlineInputBorder? border;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    cardNumber.value = creditCardModel!.cardNumber;
    expiryDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

}