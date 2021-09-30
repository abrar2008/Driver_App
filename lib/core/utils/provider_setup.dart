// provider_setup.dart
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

const bool USE_FAKE_IMPLEMENTATION = false;

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  // Provider(create: (_) => () => DB()),
  Provider<Api>(create: (_) => HttpApi()),
  ChangeNotifierProvider<GlobalTranslations>(
      create: (_) => GlobalTranslations()),
  // ChangeNotifierProvider<MessageProvider>(
  //     create: (context) => MessageProvider()),
];

List<SingleChildWidget> dependentServices = [
  // ProxyProvider<Api, AuthenticationService>(
  //     update: (context, api, authenticationService) =>
  //         AuthenticationService(api: api)),
  // ChangeNotifierProxyProvider2<Api, AuthenticationService, DoctorService>(
  //     create: (context) => DoctorService(
  //         context: context,
  //         api: Provider.of<Api>(context, listen: false),
  //         auth: Provider.of(context, listen: false)),
  //     update: (context, api, auth, doctorService) =>
  //         DoctorService(context: context, api: api, auth: auth)),
  // ChangeNotifierProxyProvider2<Api, AuthenticationService, ChatService>(
  //     create: (context) => ChatService(
  //         context: context,
  //         api: Provider.of<Api>(context, listen: false),
  //         auth: Provider.of(context, listen: false)),
  //     update: (context, api, auth, chatService) =>
  //         ChatService(context: context, api: api, auth: auth)),

  // ProxyProvider<AuthenticationService, NotificationService>(
  //     update: (context, auth, notificationService) =>
  //         NotificationService(auth: auth)),
  // ChangeNotifierProxyProvider2<Api, AuthenticationService, NotificationService>(
  //     create: (context) => NotificationService(
  //         context: context,
  //         api: Provider.of<Api>(context, listen: false),
  //         auth: Provider.of(context, listen: false)),
  //     update: (context, api, auth, notificationService) =>
  //         NotificationService(context: context, api: api, auth: auth)),
];

List<SingleChildWidget> uiConsumableProviders = [
  // ChangeNotifierProvider(create: (_) => ThemeProvider()),
  // ChangeNotifierProvider<AppLanguageModel>(create: (_) => AppLanguageModel()),
  // StreamProvider<User>(
  //     create: (context) =>
  //         Provider.of<AuthenticationService>(context, listen: false).user),
];
