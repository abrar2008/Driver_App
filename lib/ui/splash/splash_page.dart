import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/ui/splash/splash_model.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusWidget(
      child: Scaffold(
        body: BaseWidget<SplashPageModel>(
            model: SplashPageModel(
                api: Provider.of<Api>(context),
                auth: Provider.of(context),
                context: context),
            initState: (m) => WidgetsBinding.instance.addPostFrameCallback(
                (_) async => await Future.delayed(Duration(seconds: 2))
                        .then((value) async {
                      await m.getAppTranslations();
                    })),
            builder: (context, model, child) {
              final lang =
                  Provider.of<GlobalTranslations>(context, listen: false);
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/Driver_App_Splash_Screen.gif"),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      model.hasError
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RaisedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 12.0),
                                  child: Text(
                                    // AppLocalizations.of(context).continueText,
                                    lang.translate("Try again"),
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPressed: () async {
                                  await model.getAppTranslations();
                                },
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: SpinKitThreeBounce(
                                size: 82.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
