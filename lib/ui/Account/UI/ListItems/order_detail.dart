import 'package:base_notifier/base_notifier.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/Account/model/wallet_page_model/order_nifo_dialog_model.dart';
import 'package:EfendimDriverApp/core/api/api.dart';

class OrderInfoDetail extends StatelessWidget {
  final String orderId;
  OrderInfoDetail({this.orderId}) {
    print(orderId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * .8,
        child: BaseWidget<OrderInfoDialogModel>(
          //initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) => m.initializeProfileData()),
            model: OrderInfoDialogModel(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
              context: context,
              orderId: orderId,
            ),
            builder: (context, model, child) {
              return model.busy
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : model.hasError
                  ? Center(
                child: Text(model.errorMsg),
              )
                  : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                            model.order.details.item.length ?? 0,
                            itemBuilder:
                                (BuildContext context, int index) =>
                                buildExpansionCard(
                                    context, model, index)),
                      ),
                      buildTotalCOntainer(context, model)
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }

  Padding buildTotalCOntainer(
      BuildContext context, OrderInfoDialogModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "SubTotal",
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  model.order.details.total.subtotal.toString(),
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Delivery charges",
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  model.order.details.total.deliveryCharges.toString(),
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Total",
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  model.order.details.total.total.toString(),
                  // style: TextStyle(color: kMainColor),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExpansionCard(
      BuildContext context, OrderInfoDialogModel model, int index) {
    var item = model.order.details.item[index];
    Widget icon = Icon(
      Icons.arrow_circle_down,
      color: Colors.grey,
    );
    return ExpansionCard(
      onExpansionChanged: (expanded) {
        if (expanded) {
          icon = Icon(
            Icons.arrow_circle_up,
            color: Colors.grey,
          );
        } else {
          icon = Icon(
            Icons.arrow_circle_down,
            color: Colors.grey,
          );
        }
        model.setState();
      },
      title: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              icon,
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.itemName.isEmpty ? "Item" : item.itemName,
                    // style: TextStyle(
                    //   fontSize: 20,
                    //   color: Colors.black,
                    // ),
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Text(
                    "Total item price: " +
                        (double.tryParse(item.normalPrice) * item.qty)
                            .toString(),
                    // style: TextStyle(fontSize: 15, color: Colors.black),
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                "Price: " + item.normalPrice,
                // style: TextStyle(fontSize: 15, color: Colors.black),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                "Qty: " + item.qty.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                "Discount: " + (item.discount.isEmpty ? "0" : item.discount),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                "Price after discount: " + item.discountedPrice,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              Text(
                "Discount: " + item.discount,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
        )
      ],
    );
  }
}
