import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../chat_support_guest/chat_support_guest_controller.dart';
import '../chat_support_guest/chat_support_guest_page.dart';

class ChatSupportGuestFormController extends GetxController {
  static ChatSupportGuestFormController get to => Get.find();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  SmsAutoFill autoFill = SmsAutoFill();
  TextEditingController phoneController = TextEditingController();

  String email, name, phone;

  final _rxCountryCode = Rx<String>('+90');
  String get countryCode => _rxCountryCode.value;
  set countryCode(String value) => _rxCountryCode.value = value;

  String validateEmail(String text) {
    if (text.isEmpty) {
      return null;
    }

    if (!text.isEmail) {
      return 'Invalid email';
    }

    return null;
  }

  String validatePhone(String text) {
    if (text.isEmpty) {
      return 'Must not be empty';
    }

    return null;
  }

  String validateName(String text) {
    if (text.isEmpty) {
      return 'Must not be empty';
    }

    return null;
  }

  void submit() {
    if (!this.formKey.currentState.validate()) return;
    this.formKey.currentState.save();

    Get.off(
      ChatSupportGuestPage(),
      arguments: ChatSupportGuestParams(
        name: name,
        phone: countryCode + phone,
        email: email,
      ),
    );
  }
}
