import 'dart:io';
import 'dart:ui';
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/utils/icons_constants.dart';
import 'package:coloring/utils/image_constants.dart';
import 'package:coloring/view/home/widgets/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final InAppReview inAppReview = InAppReview.instance;
  Future<void> requestReview() => inAppReview.requestReview();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Exit',
                  style: GoogleFonts.skranji(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                content: Text(
                  'Are you sure you want to exit?',
                  style: GoogleFonts.skranji(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: GoogleFonts.skranji(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (Platform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (Platform.isIOS) {
                        exit(0);
                      }
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.skranji(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      requestReview();
                    },
                    child: Text(
                      'Rate Us',
                      style: GoogleFonts.skranji(
                        color: Colors.amber,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              );
            });
        return Future.value(false);
      },
      child: Consumer<DataProvider>(
        builder: (context, value, child) => Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(value.data.cover.toString()),
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.2),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        SafeArea(
                          bottom: false,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          value.data.appIcon.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  value.data.appName.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nanumBrushScript(
                                    color: Colors.white,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.60,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.71,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                ImageConstants.rectangle),
                                            fit: BoxFit.fitWidth),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xffF6F6F6),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      homeItems(
                                          context,
                                          'Categories',
                                          'Check List of main categories',
                                          IconsConstants.categories, () {
                                        Navigator.pushNamed(
                                            context, '/categories');
                                      }),
                                      homeItems(
                                          context,
                                          'Collection',
                                          'Your finished work',
                                          IconsConstants.collection, () {
                                        Navigator.pushNamed(
                                            context, '/collection');
                                      }),
                                      homeItems(
                                          context,
                                          'Profile',
                                          'Share - Settings - About Us',
                                          IconsConstants.profilehome, () {
                                        Navigator.pushNamed(
                                            context, '/profile');
                                      }),
                                      const SizedBox(
                                        height: 100,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                        )
                      ],
                    )),
              )),
        ),
      ),
    );
  }
}
