import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/wallet/order_info.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/ui/Themes/style.dart';
import 'package:EfendimDriverApp/ui/Account/model/wallet_page_model/wallet_page_model.dart';
import 'package:EfendimDriverApp/core/models/driver_wallet_model.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return BaseWidget<WalletPageModel>(
      model: WalletPageModel(
          api: Provider.of<Api>(context),
          auth: Provider.of(context),
          context: context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(lang.translate("Wallet"),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.w500,
              color: Colors.white)),
          titleSpacing: 0.0,

        ),
        body: model.busy
            ? Center(
                child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
              )
            : model.hasError
                ? Center(
                    child: Text(
                      lang.translate(model.errorMsg)??
                          lang.translate("ERROR: Something went wrong"),
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  )
                : Wallet(model: model),
      ),
    );
  }
}

class Wallet extends StatelessWidget {
  final WalletPageModel model;
  Wallet({this.model});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: ListTile(
              title: Text(
                lang.translate("Your balance").toUpperCase(),
                style: Theme.of(context).textTheme.headline6.copyWith(
                    letterSpacing: 0.67,
                    color: kHintColor,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                model.wallet.details[0].driverBalance ?? " ",
                style: listTitleTextStyle.copyWith(
                    fontSize: 35.0, color: kMainTextColor, letterSpacing: 0.18),
              ),
            ),
          ),
        ),
        Container(
          height: 40.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          color: Theme.of(context).cardColor,
          child: Text(
            lang.translate("Your Recent Order"),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: Theme.of(context).textTheme.subtitle2.color,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.08),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model.wallet.details.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Column(
              children: [
                buildWalletTile(context, model, index),
                Divider(
                  color: Theme.of(context).cardColor,
                  thickness: 5.0,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildWalletTile(
      BuildContext context, WalletPageModel model, int index) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);

    var item = model.wallet.details[index];
    return InkWell(
      onTap: () async {
        await showDialog(
          context: context,
          builder: (context) => OrderInfoDialog(orderId: item.orderId),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    item.merchantInfo.isEmpty
                        ? lang.translate("Restaurant")
                        : item.merchantInfo[0].restaurantName,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontWeight: FontWeight.bold)),
                SizedBox(height: 10.0),
                // Text('',
                //     style: Theme.of(context)
                //         .textTheme
                //         .headline6
                //         .copyWith(color: kTextColor, fontSize: 11.7)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  item?.subTotal ?? "0",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
                Text(lang.translate("Subtotal"),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).textTheme.headline6.color, fontSize: 11.7)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  item?.deliveryFee ?? "0",
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
                Text(lang.translate("Earnings"),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Theme.of(context).textTheme.headline6.color, fontSize: 11.7)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
