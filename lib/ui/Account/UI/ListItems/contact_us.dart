import 'dart:io';

import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/chats/chat_support_user/chat_support_user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/localizations/global_translations.dart';
import '../../../Components/contact_us_card.dart';
import '../../../chats/chat_support_guest_form/chat_support_guest_form_page.dart';

class ContactUs extends StatelessWidget {
  static const String id = 'support_page';
  final String number;

  ContactUs({this.number});

  @override
  Widget build(BuildContext context) {
    final GlobalTranslations lang =
        Provider.of<GlobalTranslations>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(lang.translate("Contact Us"),
            style: Theme.of(context).textTheme.bodyText1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            // Image.asset(
            //   "assets/images/calling.png",
            //   width: 320,
            // ),
            //
            Lottie.asset('assets/animation/contact-us.json',
                height: MediaQuery.of(context).size.height * .3),
            SizedBox(height: 8),
            Container(
              child: InkWell(
                onTap: directCall,
                child: Text(
                  "+90 551 068 57 50",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4))),
                      child: Text(lang.translate("Social Media:")),
                    ),
                  ],
                ),
              ),
            ),
//          #

            Card(
              elevation: 4,
              child: Container(
                child: ContactUsCard(
                  imagePath: "assets/icons/whats_app.svg",
                  label: lang.translate("Whatsapp"),
                  color: Color(0xff67C15E),
                  onTap: () async {
                    String whatsappUrl;
                    if (Platform.isIOS) {
                      whatsappUrl = "whatsapp://wa.me/$contactUsNumber/?text=";
                    } else {
                      whatsappUrl = "whatsapp://send?phone=$contactUsNumber";
                    }

                    if (await canLaunch(whatsappUrl)) {
                      await launch(whatsappUrl);
                    } else {
                      await UI.toast(lang.translate("Whatsapp not installed"));
                    }
                  },
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: Container(
                child: ContactUsCard(
                  imagePath: "assets/icons/phn.svg",
                  label: lang.translate("Direct call"),
                  color: Color(0xff3B97D3),
                  onTap: directCall,
                ),
              ),
            ),
            Card(
              elevation: 4,
              child: Container(
                child: ContactUsCard(
                  icon: Icon(Icons.chat),
                  label: lang.translate("Chat Us"),
                  color: Theme.of(context).primaryColor,
                  onTap: () async {
                    bool isLogin = Preference.getBool(PrefKeys.userLogged);
                    if (isLogin)
                      Get.to(ChatSupportUserPage());
                    else
                      Get.to(ChatSupportGuestFormPage());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  directCall() async {
    String url = "tel:$contactUsNumber";
    //  if (await canLaunch(url)) {
    await launch(url);
    // }
  }
}
