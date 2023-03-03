import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_learn_gadgets_web/core/app_string.dart';
import 'package:my_learn_gadgets_web/models/product_model.dart';
import 'package:uuid/uuid.dart';

class AddProductScreenGetController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /*  final String name;
  final String description;
  final String image;
  final List<String> secondaryImages;
  final double discountedPrice;
  final double originalPrice;
  final Map<String, dynamic> specification;
  final bool featured;
  final bool banner;
  final String category;
  final int quantityLeft;*/

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController quantityLeftController = TextEditingController();

  RxBool featured = false.obs;
  RxBool banner = false.obs;
  RxMap<String, String> specification = <String, String>{}.obs;

  RxList<String> categories = <String>[].obs;
  RxString chosenCategory = ''.obs;

  Rx<String> mainImagePath = ''.obs;
  RxList<String> secondaryImagesPath = <String>[].obs;

  RxBool showLoader = false.obs;

  void pickMainImage() {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        mainImagePath.value = value.path;
      }
    });
  }

  void pickImages() {
    ImagePicker picker = ImagePicker();
    picker.pickMultiImage().then((value) {
      secondaryImagesPath.value = [
        ...secondaryImagesPath.value,
        ...value.map((e) => e.path).toList()
      ];
    });
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      if (mainImagePath.value.isNotEmpty && secondaryImagesPath.isNotEmpty) {
        Uuid uuid = const Uuid();
        String id = uuid.v4();
        showLoader.value = true;
        await FirebaseStorage.instance
            .ref()
            .child(id)
            .child('main')
            .putFile(File(mainImagePath.value))
            .then((p0) async {
          String mainImageDownloadUrl = p0.ref.getDownloadURL().toString();
          List<String> secondaryImagesDownloadUrls = [];
          for (var element in secondaryImagesPath) {
            await FirebaseStorage.instance
                .ref()
                .child(id)
                .child('secondary')
                .child(secondaryImagesPath.indexOf(element).toString())
                .putFile(File(element))
                .then((p1) {
              secondaryImagesDownloadUrls
                  .add(p1.ref.getDownloadURL().toString());
            });
          }
          ProductModel newProduct = ProductModel(
            id: id,
            name: nameController.text,
            description: descriptionController.text,
            image: mainImageDownloadUrl,
            secondaryImages: secondaryImagesDownloadUrls,
            discountedPrice: double.parse(discountedPriceController.text),
            originalPrice: double.parse(originalPriceController.text),
            specification: specification,
            category: chosenCategory.value,
            quantityLeft: int.parse(quantityLeftController.text),
          );
          await FirebaseFirestore.instance
              .collection(AppString.products)
              .doc(id)
              .set(newProduct.toJson());
          showLoader.value = false;
        });
      } else {
        Get.snackbar('Error', 'Please select images',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  void addSpecification() {
    if (keyController.text.isNotEmpty && valueController.text.isNotEmpty) {
      specification[keyController.text] = valueController.text;
      keyController.clear();
      valueController.clear();
    }
  }

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    if(FirebaseAuth.instance.currentUser == null){
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: AppString.emailForTemporaryLogin, password: AppString.passwordForTemporaryLogin);
    }
    FirebaseFirestore.instance
        .collection(AppString.categories)
        .get()
        .then((value) {
      categories.value = value.docs.map((e) => e.id).toList();
      chosenCategory.value = categories.first;
    });
  }
}
