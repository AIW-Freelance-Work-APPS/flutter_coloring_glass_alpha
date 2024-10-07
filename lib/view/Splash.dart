import 'dart:ui';
import 'package:coloring/main.dart';
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () async {
        if (mounted) {
          if (!firstTime) {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/onboarding', (route) => false);
            }
          } else {
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
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
                    Colors.white.withOpacity(0.5),
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
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(value.data.appIcon.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                        value.data.appName.toString(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nanumBrushScript(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.70,
                        ),
                      )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Spacer(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 48, right: 48),
                                child: LinearProgressIndicator(
                                  minHeight: 7,
                                  borderRadius: BorderRadius.circular(50),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      hexToColor(value.data.mainColor.toString())),
                                  backgroundColor:
                                      Colors.white.withOpacity(0.15000000596046448),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Please wait, we are loading...',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Abel',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: -0.17,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
