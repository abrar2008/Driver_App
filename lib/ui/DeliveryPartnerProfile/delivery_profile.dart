import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/model/delivery_profile_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/ui/Components/reactive_entery_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfilePage extends StatelessWidget {
 final int status;

  ProfilePage({this.status});
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
            lang.translate("Profile Settings"),
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w500,
              color: Colors.white
            ),
          ),

        ),

        //this column contains 3 textFields and a bottom bar
        body: RegisterForm(model: model, status: status),
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
            child: Column(
              children: <Widget>[
                Divider(
                  color: Theme.of(context).cardColor,
                  thickness: 8.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            lang.translate("Featured Image").toUpperCase(),
                            style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.67,
                                color: kHintColor),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildImageContainer(image: model.path['value']),
                            SizedBox(
                                width: 40),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0, left: 40),
                              child:
                                  buildUploadFlatButton(context, onTap: () async {
                                await model.uploadPhoto(ImageType.PROFILE);
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).cardColor,
                  thickness: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        lang.translate("Profile").toUpperCase(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.67,
                            color: kHintColor),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ReactiveEntryField(
                        textCapitalization: TextCapitalization.words,
                        controller: 'team_name',
                        label: lang.translate("Team Name"),
                        enabledBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),

                        // image: 'assets/images/icons/ic_name.png',
                      ),
                    ),//name textField
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ReactiveEntryField(
                          textCapitalization: TextCapitalization.words,
                          controller: 'first_name',
                          label: lang.translate("First Name"),
                          enabledBorder: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),

                          // image: 'assets/images/icons/ic_name.png',
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ReactiveEntryField(
                          textCapitalization: TextCapitalization.words,
                          controller: 'last_name',
                          label: lang.translate("Last Name"),
                          enabledBorder: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          readOnly: status == 1 ? false : true

                          // image: 'assets/images/icons/ic_name.png',
                          ),
                    ),
                    //category textField
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ReactiveEntryField(
                        textCapitalization: TextCapitalization.words,
                        controller: 'email',
                        label: lang.translate("Email Address"),
                        enabledBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: ReactiveEntryField(
                        align: 1,
                        readOnly: true,
                        textCapitalization: TextCapitalization.words,
                        controller: 'phone',
                        label: lang.translate("Phone"),
                        enabledBorder: OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // Padding(
                    //  padding: EdgeInsets.symmetric(horizontal: 12.0),
                    //  child: ReactiveEntryField(
                    //    textCapitalization: TextCapitalization.words,
                    //   controller: 'current_pass',
                    //   label: lang.translate("password"),
                    //   enabledBorder: OutlineInputBorder(),
                    //   errorBorder: OutlineInputBorder(),
                    //   border: OutlineInputBorder(),
                    //   obscureText: true,
                    //   maxLines: 1,
                    // ),
                    // ),
                    //    Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: ReactiveEntryField(
                    //       textCapitalization: TextCapitalization.words,
                    //     controller: 'new_pass',
                    //    label: lang.translate("New Password"),
                    //    enabledBorder: OutlineInputBorder(),
                    //   errorBorder: OutlineInputBorder(),
                    //     border: OutlineInputBorder(),
                    //   obscureText: true,
                    //    maxLines: 1,
                    //  ),
                    //  ),
                    //  Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 12.0),
                    // child: ReactiveEntryField(
                    //    textCapitalization: TextCapitalization.words,
                    //  controller: 'confirm_pass',
                    //  label: lang.translate("Confirm password"),
                    //  enabledBorder: OutlineInputBorder(),
                    //  errorBorder: OutlineInputBorder(),
                    //   border: OutlineInputBorder(),
                    //   obscureText: true,
                    //    maxLines: 1,
                    // ),
                    //  ),
                    //email textField

                    SizedBox(
                      height: 5.0,
                    ),

                    Divider(
                      color: Theme.of(context).cardColor,
                      thickness: 8.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          Row(
                            children:
                            [
                              Icon(Icons.motorcycle),
                              SizedBox(
                                width: 8,),
                              Column(
                                children:
                                [
                                  Text(lang.translate('Transportation'), style:
                                  Theme.of(context).textTheme.headline6.copyWith(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.67,
                                      color: kHintColor),),
                                ],
                              )
                            ],
                          ),
                          ReactiveDropdownField(
                            readOnly: status == 1 ? false : true,
                            hint: model.form.control('transport_type_id').value !=
                                null
                                ? Text(lang.translate(model.form
                                .control('transport_type_id')
                                .value))
                                : Text(lang.translate('Transportation')),
                            items: model.types
                                .map((item) => DropdownMenuItem<dynamic>(
                              value: item['key'],
                              child: new Text(
                                lang.translate(item['key']),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .secondaryHeaderColor,
                                    fontSize: 12.5),
                              ),
                            ))
                                .toList(),
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              // filled: true,
                              // fillColor: Colors.grey[200],
                              // prefix: Text("Type: "),
                              errorBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(30.0),
                                // borderSide: BorderSide(
                                //   color: Colors.red,
                                //   width: 2.0,
                                // ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(30.0),
                                // borderSide: BorderSide(
                                //     // color: AppColors.mainColor,
                                //     ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(30.0),
                                // borderSide: BorderSide(
                                //   color: Colors.grey[200],
                                //   width: 2.0,
                                // ),
                              ),
                              labelStyle: TextStyle(color: Colors.blue),
                            ),
                            formControlName: 'transport_type_id',
                            onChanged: (item) {
                              String key = item;
                              model.form
                                  .control('transport_type_id')
                                  .updateValue(key);
                              if (model.auth.userProfile.details.transportList
                                  .toJson()
                                  .containsKey(key)) {
                                model.form
                                    .control('transport_description')
                                    .updateValue(model
                                    .auth.userProfile.details.transportList
                                    .toJson()[key]);
                              } else {
                                model.form
                                    .control('transport_description')
                                    .updateValue(key);
                              }
                              model.setState();
                            },
                          ),

                          SizedBox(height: 15,),

                          ReactiveEntryField(
                            textCapitalization: TextCapitalization.words,
                            controller: 'transport_description',
                            label: lang.translate("the description"),
                            enabledBorder: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),

                            // image: 'assets/images/icons/ic_name.png',
                          ),

                          SizedBox(
                            height: 10,),
                          ReactiveEntryField(
                            textCapitalization: TextCapitalization.words,
                            controller: 'licence_plate',
                            label: lang.translate("plate Number"),
                            enabledBorder: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),

                            // image: 'assets/images/icons/ic_name.png',
                          ),
                          ReactiveEntryField(
                            textCapitalization: TextCapitalization.words,
                            controller: 'color',
                            label: lang.translate("the color"),
                            enabledBorder: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),

                            // image: 'assets/images/icons/ic_name.png',
                          ),

                          SizedBox(
                            height: 10,),
                        ],
                      ),
                    ),
                    //phone textField
                  ],
                ),
                Divider(
                  color: Theme.of(context).cardColor,
                  thickness: 8.0,
                ),
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
              ? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,))
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBar(
                      text: lang.translate("Update"),
                      onTap: () async {
                        // Navigator.popAndPushNamed(context, PageRoutes.accountPage);
                        model.updateProfile();
                      }),
                )
        ],
      ),
    );
  }

  Widget buildDocumentationColumn(BuildContext context)
  {
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
          child: Container(
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

                trailing: buildUploadFlatButton(context, onTap: () async
                {
                    await model.uploadPhoto(ImageType.GOVERNMENT_ID);

                })),
          ),
        ),
        model.governmentID['key'] != 'not_uploaded'
            ? Center(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 2.0, color:  Color(Theme.of(context).primaryColor.value))),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: buildImageContainer(
                          image: model.governmentID['value']
                                  .startsWith(model.baseUrl)
                              ? model.governmentID['value']
                              : model.baseUrl + model.governmentID['value'])),
                ),
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
              trailing: buildUploadFlatButton(context, onTap: () async
              {
                await model.uploadPhoto(ImageType.LICENSE);
              })),
        ),
        model.license['key'] != 'not_uploaded'
            ? Center(
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 2.0, color:  Color(Theme.of(context).primaryColor.value))),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: buildImageContainer(
                        image: model.license['value'].startsWith(model.baseUrl)
                            ? model.license['value']
                            : model.baseUrl + model.license['value']),
                  ),
                ),
              )
            : SizedBox(),
        Container(
          height: 80.0,
          color: Theme.of(context).cardColor,
        ),
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
              child: CircularProgressIndicator(backgroundColor: kMainColor,),
            )
          : CachedNetworkImage(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              imageUrl: image ?? " ",
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,),
              ),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
    );
  }

  Widget buildUploadFlatButton(BuildContext context, {Future<Null> onTap()}) {
    return Container(
      height: ScreenUtil.screenHeightDp * .05,
      width: ScreenUtil.screenWidthDp * .3,
      child: TextButton(
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
