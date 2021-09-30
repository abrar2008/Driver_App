import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';

class SupportPage extends StatelessWidget {
  static const String id = 'support_page';
  final String number;

  SupportPage({this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   drawer: AccountDrawer(),
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(AppLocalizations.of(context).support,
            style: Theme.of(context).textTheme.bodyText1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            color: Theme.of(context).cardColor,
            child: Image(
              image: AssetImage("assets/images/logo_delivery.png"),
              height: 130.0,
              width: 99.7,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    AppLocalizations.of(context).orWrite,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
                  child: Text(
                    AppLocalizations.of(context).yourWords,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                EntryField(
                  image: 'assets/images/icons/ic_phone.png',
                  label: AppLocalizations.of(context).mobileNumber,
                  initialValue: '+1 987 654 3210',
                  readOnly: true,
                ),
                EntryField(
                  image: 'assets/images/icons/ic_mail.png',
                  label: AppLocalizations.of(context).message,
                  hint: AppLocalizations.of(context).enterMessage,
                  maxLines: 5,
                ),
              ],
            ),
          ),
          Spacer(),
          BottomBar(
            text: AppLocalizations.of(context).submit,
            onTap: () {
              /*............*/
            },
          ),
        ],
      ),
    );
  }
}
