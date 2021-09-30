import 'dart:io';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/language_cubit.dart';
import 'package:EfendimDriverApp/theme_cubit.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/ui/Account/model/settings_page_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:device_info/device_info.dart';
import 'package:toaster/toaster.dart';

class ThemeList {
  final String title;
  final String subtitle;

  ThemeList({this.title, this.subtitle});
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LanguageCubit _languageCubit;
  bool isSwitched = true;

  ThemeCubit _themeCubit;

  String selectedLocal = 'English';

  String selectedTheme = 'Light Mode';
  String deviceName;
  String deviceVersion;
  String identifier;
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  Widget build(BuildContext context) {
    // _languageCubit = BlocProvider.of<LanguageCubit>(context);
    _themeCubit = BlocProvider.of<ThemeCubit>(context);

    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(lang.translate("Settings"),
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.w500,
              color: kMainTextColor)),
          titleSpacing: 0.0,

        ),
        body: BaseWidget<SettingsPageModel>(
            model: SettingsPageModel(
              api: Provider.of<Api>(context),
              auth: Provider.of(context),
              context: context,
            ),
            builder: (context, model, child) {
              final lang =
                  Provider.of<GlobalTranslations>(context, listen: false);

              final List<ThemeList> themes = <ThemeList>[
                ThemeList(
                  title: lang.translate('Dark Mode'),
                  subtitle: lang.translate('Experience an exciting dark mode'),
                ),
                ThemeList(
                  title: lang.translate('Light Mode'),
                  subtitle: lang.translate('Experience an exciting light mode'),
                ),
              ];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.translate("device_id"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontSize: 18.3,
                                              ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      _deviceData['androidId'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                        color: Theme.of(context).secondaryHeaderColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 2.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(lang.translate("notifications"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 18.3,

                                          ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      lang.translate("enable_notification"),
                                      style: TextStyle(
                                          color: Theme.of(context).textTheme.headline6.color,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Switch(
                                      activeColor: kMainColor,
                                        value: isSwitched,
                                        onChanged: (value) {
                                          setState(() {
                                            isSwitched = value;
                                            if (value == true) {
                                              Toaster.toast(
                                                  message:
                                                      lang.translate("Notification Enabled"),
                                                  duration: Duration.LONG);
                                            } else if (value == false) {
                                              Toaster.toast(
                                                  message:lang.translate("Notification Disabled"),
                                                  duration: Duration.SHORT);
                                            }
                                          });
                                        }),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 57.7,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lang.translate("Display"),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.08),
                            ),
                          ),
                        ),
                        RadioButtonGroup(
                            activeColor: kMainColor,
                            picked: selectedTheme,
                            labelStyle: Theme.of(context).textTheme.caption,
                            onSelected: (selected) => setState(() {
                                  if (selected == lang.translate('Dark Mode')) {
                                    selectedTheme = lang.translate('Dark Mode');
                                  } else if (selected ==
                                      lang.translate('Light Mode')) {
                                    selectedTheme =
                                        lang.translate('Light Mode');
                                  }
                                }),
                            labels: themes.map((e) => e.title).toList(),
                            itemBuilder:
                                (Radio radioButton, Text title, int i) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    height: 65.0,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ListTile(
                                        trailing: radioButton,
                                        title: Text(
                                          themes[i].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 18.3,
                                                  color: Theme.of(context).textTheme.headline6.color),
                                        ),
                                        subtitle: Text(
                                          themes[i].subtitle,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0)
                                ],
                              );
                            }),
                        Container(
                          height: 58.0,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lang.translate("Select language"),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Theme.of(context).secondaryHeaderColor,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.08),
                            ),
                          ),
                        ),
                        model.busy
                            ? Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,))
                            : model.hasError
                                ? Center(
                                    child: Text(lang.translate(
                                        "ERROR: Something went wrong")),
                                  )
                                : RadioButtonGroup(
                                    activeColor: kMainColor,
                                    picked: selectedLocal,
                                    labelStyle:
                                        Theme.of(context).textTheme.caption,
                                    onSelected: (selected) async {
                                      setState(() {
                                        selectedLocal = selected;
                                      });
                                      await lang.setNewLanguage(selectedLocal);
                                      //Preference.setString(Constants.APP_TRANSLATIONS_KEY, selectedLocal);


                                       await lang.init(selectedLocal);
                                    },
                                    labels: model.languagesKeys,
                                    itemBuilder:
                                        (Radio radioButton, Text title, int i) {
                                          print("key..${model.languagesKeys[i]}");
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            height: 52,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                              ),
                                              child: ListTile(
                                                trailing: radioButton,
                                                title: Text(
                                                  model.languagesKeys[i],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6
                                                      .copyWith(
                                                          fontSize: 18.3,
                                                          color: Theme.of(context).textTheme.headline6.color),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0)
                                        ],
                                      );
                                    },
                                  ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomBar(
                          text: lang.translate("Continue"),
                          onTap: model.idle
                              ? () async {
                                  if (selectedTheme ==
                                      lang.translate("Dark Mode")) {
                                    _themeCubit.selectDarkTheme();
                                  } else if (selectedTheme ==
                                      lang.translate("Light Mode")) {
                                    _themeCubit.selectLightTheme();
                                  }
                                  Navigator.pop(context);
                                }
                              : null),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
