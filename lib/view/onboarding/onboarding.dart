import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/utils/colors_utils.dart';
import 'package:coloring/utils/image_constants.dart';
import 'package:coloring/view/onboarding/widgets/indicator.dart';
import 'package:coloring/view/onboarding/widgets/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController controller = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Stack(
                    children: [
                      PageView(
                        controller: controller,
                        children: [
                          for (var i = 0; i < value.data.intro!.length; i++)
                            onboardingItem(context, value, i),
                        ],
                        onPageChanged: (int index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.2,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 90,
                            maxHeight: 100,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageConstants.waves),
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              color: const Color(0xffFFFCFC),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        indicatorItems(value, currentPage),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: const Color(0xffFFFCFC),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.data.intro![currentPage]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.quicksand(
                                                color: const Color(0xFF27214D),
                                                fontSize: 45,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Opacity(
                                              opacity: 0.60,
                                              child: Text(
                                                value.data.intro![currentPage]
                                                    .description
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                maxLines: 2,
                                                style: GoogleFonts.abel(
                                                  color:
                                                      const Color(0xFF5C577E),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () {
                                        if (currentPage ==
                                            value.data.intro!.length - 1) {
                                          Navigator.pushReplacementNamed(
                                              context, '/home');
                                        }
                                        if (currentPage <
                                            value.data.intro!.length - 1) {
                                          controller.nextPage(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeIn,
                                          );
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height: 51,
                                        decoration: ShapeDecoration(
                                          color: hexToColor(
                                              value.data.mainColor.toString()),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          currentPage == 0
                                              ? 'Get Started'
                                              : 'Continue',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.24,
                                          ),
                                        )),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 40),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
