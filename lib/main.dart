import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/services/notifications.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/themes/dark_theme.dart';
import 'package:news_app/themes/light_theme.dart';
import 'package:wp_json_api/wp_json_api.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print(message.notification?.title.toString());
  }
  if (kDebugMode) {
    print(message.notification?.body.toString());
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WPJsonAPI.instance.init(baseUrl: "https://nexmart.great-site.net");
  runApp(const NewsApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  final NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeNotifications();
  }
  Future<void> _initializeNotifications() async {
    await notificationServices.initialize();
    notificationServices.onTokenRefresh();
    String? token = await notificationServices.getDeviceToken();
    if (token != null) {
      if (kDebugMode) {
        print("Device Token: $token");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('ur', 'PK'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale('ur', 'PK'),
        home: const SplashScreen(),
      ),
    );
  }
}