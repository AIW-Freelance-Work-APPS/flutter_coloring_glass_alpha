import 'dart:convert';
import 'package:coloring/model/data.dart';
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/model_view/menu_provider.dart';
import 'package:coloring/view/Splash.dart';
import 'package:coloring/view/brand.dart';
import 'package:coloring/view/categories/categories.dart';
import 'package:coloring/view/collection/collection.dart';
import 'package:coloring/view/home/home.dart';
import 'package:coloring/view/onboarding/onboarding.dart';
import 'package:coloring/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

///creat by Mfagri
Data data = Data();

//this for package info
PackageInfo? packageInfo = PackageInfo(
  appName: 'Unknown',
  packageName: 'Unknown',
  version: 'Unknown',
  buildNumber: 'Unknown',
);

bool firstTime = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();
  //read json file from assets
  final json = await rootBundle.loadString('assets/db.json');
  final config = jsonDecode(json);
  data = Data.fromJson(config);

  //camera permission
  SharedPreferences prefs = await SharedPreferences.getInstance();
  firstTime = (prefs.getBool('isfirsttime') ?? false);
  if (!firstTime) {
    prefs.setBool('isfirsttime', true);
  }
  // for testing multiple devices
  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => const MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => MenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          scaffoldBackgroundColor: const Color(0xffFFFCFC),
          useMaterial3: true,
        ),
        initialRoute: '/brand',
        routes: {
          '/': (context) => const SplashScreen(),
          '/brand': (context) => const BrandScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
          '/profile': (context) => const Profile(),
          '/home': (context) => const HomePage(),
          '/categories': (context) => const CategoriesPage(),
          '/collection': (context) => const CollectionPage(),
        },
      ),
    );
  }
}
