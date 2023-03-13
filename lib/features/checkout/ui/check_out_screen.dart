import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:my_learn_gadgets_web/core/app_colors.dart';

import '../../../core/app_string.dart';
import '../../../models/cart_item.dart';
import '../../shopping_cart/get_controllers/shopping_cart_get_controller.dart';
import '../get_controllers/check_out_get_controller.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({Key? key}) : super(key: key);
  ShoppingCartGetController getController =
      Get.put(ShoppingCartGetController());

  CheckOutGetController checkOutGetController =
      Get.put(CheckOutGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Out'),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.3, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:", style: TextStyle(fontSize: 20)),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection(AppString.users)
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection(AppString.shoppingCart)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<CartItem> products = snapshot.data!.docs
                                  .map((e) => CartItem.fromJson(
                                      jsonDecode(jsonEncode(e.data()))))
                                  .toList();

                              checkOutGetController.products.value = products;
                              return Text(
                                  products.isNotEmpty
                                      ? "Rs. ${products.map((e) => e.product.discountedPrice * e.quantity).reduce((value, element) => value + element)}"
                                      : "Rs. 0.0",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500));
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ]),
                Divider(
                  thickness: 2,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: checkOutGetController.addressLine1Controller,
                  decoration: InputDecoration(
                    labelText: "Address Line 1",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: checkOutGetController.addressLine2Controller,
                  decoration: InputDecoration(
                    labelText: "Address Line 2",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: checkOutGetController.cityController,
                        decoration: InputDecoration(
                          labelText: "City",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFormField(
                        controller: checkOutGetController.stateController,
                        decoration: InputDecoration(
                          labelText: "State",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: checkOutGetController.pinCodeController,
                  decoration: InputDecoration(
                    labelText: "Pin Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: checkOutGetController.phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                const Text("Your Card Info",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: Get.width * 0.2,
                      child: CreditCardWidget(
                        glassmorphismConfig:
                            checkOutGetController.useGlassMorphism.value
                                ? Glassmorphism.defaultConfig()
                                : null,
                        cardNumber: checkOutGetController.cardNumber.value,
                        expiryDate: checkOutGetController.expiryDate.value,
                        cardHolderName:
                            checkOutGetController.cardHolderName.value,
                        cvvCode: checkOutGetController.cvvCode.value,
                        bankName: 'Axis Bank',
                        frontCardBorder:
                            Border.all(color: AppColors.primaryColor.shade500),
                        backCardBorder:
                            Border.all(color: AppColors.primaryColor.shade500),
                        showBackView: checkOutGetController.isCvvFocused.value,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        isHolderNameVisible: true,
                        cardBgColor: AppColors.cardBgColor,
                        backgroundImage:
                            checkOutGetController.useGlassMorphism.value
                                ? 'assets/images/card_bg.png'
                                : null,
                        isSwipeGestureEnabled: true,
                        onCreditCardWidgetChange:
                            (CreditCardBrand creditCardBrand) {},
                        customCardTypeIcons: <CustomCardTypeIcon>[
                          CustomCardTypeIcon(
                            cardType: CardType.mastercard,
                            cardImage: Image.asset(
                              'assets/images/mastercard.png',
                              height: 48,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CreditCardForm(
                      formKey: checkOutGetController.formKey,
                      obscureCvv: true,
                      obscureNumber: true,
                      cardNumber: checkOutGetController.cardNumber.value,
                      cvvCode: checkOutGetController.cvvCode.value,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardHolderName:
                          checkOutGetController.cardHolderName.value,
                      expiryDate: checkOutGetController.expiryDate.value,
                      themeColor: Colors.blue,
                      textColor: AppColors.primaryColor.shade500,
                      cardNumberDecoration: InputDecoration(
                        labelText: 'Credit/Debit Card Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                        hintStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        labelStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        focusedBorder: checkOutGetController.border,
                        enabledBorder: checkOutGetController.border,
                      ),
                      expiryDateDecoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        labelStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        focusedBorder: checkOutGetController.border,
                        enabledBorder: checkOutGetController.border,
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        labelStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        focusedBorder: checkOutGetController.border,
                        enabledBorder: checkOutGetController.border,
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        labelStyle:
                            TextStyle(color: AppColors.primaryColor.shade500),
                        focusedBorder: checkOutGetController.border,
                        enabledBorder: checkOutGetController.border,
                        labelText: 'Card Holder Name',
                      ),
                      onCreditCardModelChange:
                          checkOutGetController.onCreditCardModelChange,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/upilogo.png',
                              ),
                              width: 60,
                              height: 60,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/phonepaylogo.png',
                              ),
                              width: 60,
                              height: 100,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/gpay.png',
                              ),
                              width: 60,
                              height: 60,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage(
                                'assets/images/bhimlogo.png',
                              ),
                              width: 60,
                              height: 60,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() {
                        return NeumorphicButton(
                          onPressed: () {
                            checkOutGetController.pay();
                          },
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.convex,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(8)),
                              depth: 3,
                              intensity: 5,
                              lightSource: LightSource.topLeft,
                              color: Colors.white),
                          padding: const EdgeInsets.all(12),
                          child: checkOutGetController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: AppColors.primaryColor,
                                    ),
                                    const Text(
                                      "Pay Now",
                                    ),
                                  ],
                                ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
