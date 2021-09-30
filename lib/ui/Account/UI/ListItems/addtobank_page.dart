import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/ui/Themes/style.dart';

class AddToBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).sendToBank,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w500)),
        titleSpacing: 0.0,
      ),
      body: Add(),
    );
  }
}

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .availableBalance
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              letterSpacing: 0.67,
                              color: kHintColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        '\$ 520.50',
                        style: listTitleTextStyle.copyWith(
                            fontSize: 35.0,
                            color: kMainTextColor,
                            letterSpacing: 0.18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
              thickness: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      AppLocalizations.of(context).bankInfo.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.67,
                          color: kHintColor),
                    ),
                  ),
                  EntryField(
                    textCapitalization: TextCapitalization.words,
                    label: AppLocalizations.of(context)
                        .accountHolderName
                        .toUpperCase(),
                    initialValue: 'Samantha Smith',
                  ),
                  EntryField(
                    textCapitalization: TextCapitalization.words,
                    label: AppLocalizations.of(context).bankName.toUpperCase(),
                    initialValue: 'HBNC Bank of New York',
                  ),
                  EntryField(
                    textCapitalization: TextCapitalization.none,
                    label:
                        AppLocalizations.of(context).branchCode.toUpperCase(),
                    initialValue: '+1 987 654 3210',
                  ),
                  EntryField(
                    textCapitalization: TextCapitalization.none,
                    label: AppLocalizations.of(context)
                        .accountNumber
                        .toUpperCase(),
                    initialValue: '4321 4567 6789 8901',
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
              thickness: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: EntryField(
                textCapitalization: TextCapitalization.words,
                label: AppLocalizations.of(context)
                    .enterAmountToTransfer
                    .toUpperCase(),
                initialValue: '\$ 500',
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomBar(
            text: AppLocalizations.of(context).sendToBank,
            onTap: () => Navigator.pop(context),
          ),
        )
      ],
    );
  }
}
