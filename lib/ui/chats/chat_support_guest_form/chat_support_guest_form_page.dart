import 'package:EfendimDriverApp/ui/Components/alternative_text_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_support_guest_form_controller.dart';

class ChatSupportGuestFormPage extends StatelessWidget {
  final controller = Get.put(ChatSupportGuestFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            AlternativeTextField(
              onSaved: (newValue) => controller.name = newValue,
              validator: controller.validateName,
              label: 'Name*',
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                // String phone = controller.phone.text.replaceAll(" ", "");
                // if (phone.startsWith("0")) {
                //   phone = phone.substring(1);
                // }
              },
              child: AlternativeTextField(
                controller: controller.phoneController,
                onSaved: (newValue) => controller.phone = newValue,
                validator: controller.validatePhone,
                hint: 'Mobile*',
                keyboardType: TextInputType.phone,
                isPhoneNumber: true,
                isAutoFill: true,
                autoFill: () async {
                  String autoFilPhone = await controller.autoFill.hint;
                  controller.phoneController.text = autoFilPhone.substring(
                    controller.countryCode.length,
                  );
                },
                prefix: Directionality(
                  child: CountryCodePicker(
                    onChanged: (country) {
                      controller.countryCode = country.dialCode;
                    },
                    onInit: (value) {
                      controller.countryCode = value.dialCode;
                    },
                    initialSelection: controller.countryCode,
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    padding: EdgeInsets.all(4),
                    flagWidth: 18,
                    textStyle: TextStyle(
                      letterSpacing: .23,
                      fontSize: 16.0,
                      locale: Locale('en'),
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
            SizedBox(height: 10),
            AlternativeTextField(
              onSaved: (newValue) => controller.email = newValue,
              validator: controller.validateEmail,
              label: 'Email',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.submit,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
