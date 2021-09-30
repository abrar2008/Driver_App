import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Components/entry_field.dart';
import 'package:EfendimDriverApp/ui/Locale/locales.dart';
import 'package:EfendimDriverApp/ui/Routes/routes.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/model/delivery_profile_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/ui/Components/reactive_entery_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UploadDocumentPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return BaseWidget<DeliveryProfilePageModel>(
      model: DeliveryProfilePageModel(
          context: context,
          api: Provider.of<Api>(context),
          auth: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            lang.translate("Upload document"),
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 16.7),
          ),
        ),
        //this column contains 3 textFields and a bottom bar
        body: RegisterForm(model: model, status: 1),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final DeliveryProfilePageModel model;
  int status;

  RegisterForm({this.model, this.status});

  GlobalTranslations lang = GlobalTranslations();

  @override
  Widget build(BuildContext context) {
    print("isbusy..${model.busy}");
    return ReactiveForm(
      formGroup: model.form,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding:   EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                model.busy
                    ? Center(
                  child: Text(""),
                  //    child: CircularProgressIndicator(),
                )
                    : model.hasError
                    ? Center(
                  child: Text(
                      lang.translate("ERROR: Something went wrong")),
                )
                    : buildDocumentationColumn(context),
              ],
            ),
          ),
          model.busy
              ? Center(child: CircularProgressIndicator())
              : Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(
                text: lang.translate("Update"),
                onTap: () async {
                  // Navigator.popAndPushNamed(context, PageRoutes.accountPage);
                  model.updateProfile(isPop:false);
                }),
          )
        ],
      ),
    );
  }

  Widget buildDocumentationColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Text(
            lang.translate("Documentation").toUpperCase(),
            style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.67,
                color: kHintColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: ListTile(
              leading: Image.asset(
                'assets/images/icons/id1.png',
                height: ScreenUtil.screenHeightDp / 15,
                color: kMainColor,
              ),
              title: Text(
                lang.translate("Government ID"),
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Color(0xff838383)),
              ),
              subtitle: Text(
                lang.translate(model.governmentID['key']) ??
                    lang.translate("Upload failed"),
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: buildUploadFlatButton(context, onTap: () async {
                status == 1
                    ? await model.uploadPhoto(ImageType.GOVERNMENT_ID)
                    : {};
              })),
        ),
        model.governmentID['key'] != 'not_uploaded'
            ? Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 16),
              child: buildImageContainer(
                  image: model.governmentID['value']
                      .startsWith(model.baseUrl)
                      ? model.governmentID['value']
                      : model.baseUrl + model.governmentID['value'])),
        )
            : SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListTile(
              leading: Image.asset('assets/images/icons/id1.png',
                  height: ScreenUtil.screenHeightDp / 15, color: kMainColor),
              title: Text(
                lang.translate("License Plate").toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Color(0xff838383)),
              ),
              subtitle: Text(
                lang.translate(model.license['key']) ??
                    lang.translate('Upload failed'),
                style: Theme.of(context).textTheme.caption,
              ),
              trailing: buildUploadFlatButton(context, onTap: () async {
                status == 1 ? await model.uploadPhoto(ImageType.LICENSE) : {};
              })),
        ),
        model.license['key'] != 'not_uploaded'
            ? Center(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: buildImageContainer(
                image: model.license['value'].startsWith(model.baseUrl)
                    ? model.license['value']
                    : model.baseUrl + model.license['value']),
          ),
        )
            : SizedBox(),
      ],
    );
  }

  Widget buildImageContainer(
      {@required String image, double width, double height}) {
    height ??= ScreenUtil.screenHeightDp * .15;
    width ??= ScreenUtil.screenWidthDp * .25;
    return Container(
      height: height,
      width: width,
      //color: Theme.of(context).cardColor,
      child: model.uploading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : CachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        imageUrl: image ?? " ",
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.broken_image),
      ),
    );
  }

  Widget buildUploadFlatButton(BuildContext context, {Future<Null> onTap()}) {
    return Container(
      height: ScreenUtil.screenHeightDp * .05,
      width: ScreenUtil.screenWidthDp * .3,
      child: FlatButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                color: kMainColor,
                size: 19.0,
              ),
              SizedBox(width: 14.3),
              Expanded(
                child: Text(
                  lang.translate("Upload"),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: kMainColor),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          onPressed: onTap),
    );
  }
}
