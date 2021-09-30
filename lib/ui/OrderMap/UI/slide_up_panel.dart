import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';
import 'package:EfendimDriverApp/core/models/order_detail_info.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:provider/provider.dart';

class OrderInfoContainer extends StatefulWidget {
  // final List<String> itemName;
  final OrderDetailModel orderDetailModel;
  OrderInfoContainer({this.orderDetailModel});

  @override
  _OrderInfoContainerState createState() => _OrderInfoContainerState();
}

class _OrderInfoContainerState extends State<OrderInfoContainer> {
  List<double> prices = [
    3.00,
    4.50,
    2.50,
  ];

  double sum() {
    double total = 0.00;
    for (int i = 0; i < prices.length; i++) {
      total += prices[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Column(
      children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.orderDetailModel.details.item.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListTile(
                title: Text(
                  lang.translate(widget.orderDetailModel.details.item[index].itemName),
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
                trailing: FittedBox(
                  child: Row(
                    children: [
                      Text(
                        lang.translate(widget.orderDetailModel.details.item[index].qty.toString()),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 15.0),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Text(
                        '\$ ${widget.orderDetailModel.details.item[index].itemName.toString()}0',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Container(
          height: 50.0,
          color: kMainColor,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  lang.translate("Cash on Delivery"),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: kWhiteColor),
                ),
                Text(
                  '\$ ${widget.orderDetailModel.details.total.total.toString()}',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: kWhiteColor, fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ],
    );
  }
}
