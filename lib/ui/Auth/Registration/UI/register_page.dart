import 'dart:io';

import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/model/delivery_profile_model.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/ui/Auth/Registration/model/registration_page_model.dart';
import 'package:EfendimDriverApp/ui/Auth/login_navigator.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:EfendimDriverApp/ui/Components/reactive_entery_field.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/delivery_profile.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/Components/alternative_dropdown_list.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//register page for registration of a new user
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return BaseWidget<RegistrationPageModel>(
      model: RegistrationPageModel(
          api: Provider.of<Api>(context),
          auth: Provider.of(context),
          context: context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            lang.translate("Register now"),
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
          ),
        ),

        bottomNavigationBar:  BottomBar(
            text: lang.translate("Continue"),
            onTap: () {
              // Navigator.pushNamed(context, LoginRoutes.verification);
              model.signUp();
              // print(model.form.value);
            }),
        //this column contains 3 textFields and a bottom bar
        body: RegisterForm(model: model),
      ),
    );
  }
}

bool uploading = false;
File choosedImage;

Map<String, String> path = {'key': '', 'value': ''};
Map<String, String> license = {'key': '', 'value': ''};
Map<String, String> governmentID = {'key': '', 'value': ''};



class RegisterForm extends StatelessWidget {
  final RegistrationPageModel model;
  RegisterForm({this.model});

  GlobalTranslations lang = GlobalTranslations();

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
        formGroup: model.form,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Divider(
                    color: Theme.of(context).cardColor,
                    thickness: 8.0,
                  ),

                  //First name
                  ReactiveEntryField(
                    textCapitalization: TextCapitalization.words,
                    controller: 'first_name',
                    label: lang.translate("First Name").toUpperCase(),
                    image: 'assets/images/icons/ic_name.png',
                  ),

                  // Last name
                  ReactiveEntryField(

                    textCapitalization: TextCapitalization.words,
                    controller: 'last_name',
                    label: lang.translate("Last Name").toUpperCase(),
                    image: 'assets/images/icons/ic_name.png',
                  ),

                  // Username
                  ReactiveEntryField(
                    textCapitalization: TextCapitalization.words,
                    controller: 'username',
                    label: lang.translate("User Name").toUpperCase(),
                    image: 'assets/images/icons/ic_name.png',
                  ),

                  //Email
                  ReactiveEntryField(
                    textCapitalization: TextCapitalization.none,
                    controller: 'email',
                    label: lang.translate("Email address").toUpperCase(),
                    image: 'assets/images/icons/ic_mail.png',
                    keyboardType: TextInputType.emailAddress,
                  ),

                  model.fetchingTransport
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      // : AlternativeDropdownList(
                      //     key: UniqueKey(),
                      //     displayLabel: "name",
                      //     labels: model.types,
                      //     onChange: (item) {
                      //       model.selectedItem = item;
                      //       model.setState();
                      // },

                      // ),
                      : ReactiveDropdownField(
                          // isExpanded: true,

                          hint: Text(lang.translate("Please select")),
                          items: model.types
                              .map((item) => DropdownMenuItem<dynamic>(
                                    value: item["key"],
                                    child: new Text(
                                      item["value"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ))
                              .toList(),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Colors.grey[200],
                            prefix:
                                Text(lang.translate("transport_type") + ": "),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  // color: AppColors.mainColor,
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.grey[200],
                                width: 2.0,
                              ),
                            ),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          formControlName: 'transport_type_id',
                        ),
                  Divider(
                    color: Theme.of(context).cardColor,
                    thickness: 8.0,
                  ),
                ]),
          ),
        ));
  }


  buildButton(BuildContext context, CountryCode isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
