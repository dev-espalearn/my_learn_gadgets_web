import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutGetController extends GetxController{
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
}