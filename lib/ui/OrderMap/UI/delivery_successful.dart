import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/core/models/order_details_model.dart';
import 'package:EfendimDriverApp/ui/OrderMap/model/delivery_successful_model.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes copy/route_new.dart';


class DeliverySuccessful extends StatelessWidget
{
  OrderModel orderDetails;

  DeliverySuccessful({this.orderDetails});
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return BaseWidget<DeliverySuccessfulModel>(
      model: DeliverySuccessfulModel(
        api: Provider.of<Api>(context),
        auth: Provider.of(context),
        orderDetails: orderDetails.details.total,
      ),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Image.asset(
                'assets/images/Driver_Character.png',
                height: 350,
                width: 300,
              ),
            ),
            Text(
              lang.translate("Delivered Successfully !"),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).secondaryHeaderColor,
                  letterSpacing: 0.1),
            ),
            SizedBox(height: 15,),
            Text(
              lang.translate("Thank you for deliver safely & on time."),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.normal),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 31.0, right: 31.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lang.translate("You drived"),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Color(0xff818181)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        //model.details.total.total = null ? 'null' : model.details.total.total,
                        '18 min (6.5km)',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                      ),

                      SizedBox(
                        height: 5.0,
                      ),
                      TextButton(
                        child:Text(lang.translate("View order info"),
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: kMainColor,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.08),
                        ),
                        onPressed: (){},  //order Info page
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        lang.translate("Earnings"),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Color(0xff818181)),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '\$ ${model.orderDetails.calculationMethod}',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            lang.translate("View Earnings"),
                            style: Theme.of(context).textTheme.headline4.copyWith(
                                color: kMainColor,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.08),
                          ),
                        ),
                        onPressed: (){}, //order earnings page
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomBar(
                text: lang.translate("back to homepage"),
                onTap: () => UI.pushReplaceAll(context, Routes.allTasks))
          ],
        ),

      )

    );
  }
}




