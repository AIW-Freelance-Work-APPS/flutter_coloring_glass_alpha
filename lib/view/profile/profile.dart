import 'dart:io';
import 'dart:ui';
import 'package:coloring/main.dart';
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/utils/icons_constants.dart';
import 'package:coloring/utils/image_constants.dart';
import 'package:coloring/utils/utils.dart';
import 'package:coloring/view/profile/webview.dart';
import 'package:coloring/view/profile/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/builder_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final InAppReview inAppReview = InAppReview.instance;
  @override
  void initState() {
    super.initState();
  }

  Future<void> openStoreListing() => inAppReview.openStoreListing(
      appStoreId: packageInfo!.packageName,
      microsoftStoreId: packageInfo!.packageName);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(value.data.cover.toString()),
              fit: BoxFit.fill,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.89,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(ImageConstants.rectangle),
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
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.82,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Opacity(
                                    opacity: 0.70,
                                    child: Text(
                                      'Support us',
                                      style: GoogleFonts.museoModerno(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              profileItem(
                                  context, 'Rate Us', IconsConstants.rateus,
                                  () {
                                openStoreListing();
                                // _requestReview();
                              }),
                              profileItem(
                                  context, 'Contact Us', IconsConstants.contact,
                                  () {
                                final Uri emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: value.data.contact,
                                  query: encodeQueryParameters(<String, String>{
                                    'subject': 'Feedback',
                                  }),
                                );
                                launchUrl(emailLaunchUri);
                              }),
                              profileItem(context, 'Share with friends',
                                  IconsConstants.share, () {
                                if (Platform.isIOS) {
                                  Share.share(
                                      'https://apps.apple.com/us/app/${packageInfo!.packageName}/id${packageInfo!.buildSignature}');
                                } else {
                                  Share.share(
                                      'https://play.google.com/store/apps/details?id=${packageInfo!.packageName}');
                                }
                              }),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Opacity(
                                    opacity: 0.70,
                                    child: Text(
                                      'About the app',
                                      style: GoogleFonts.museoModerno(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              profileItem(
                                  context, 'About us', IconsConstants.aboutus,
                                  () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WebviewScreen(
                                      url: value.data.about!,
                                      title: 'About us');
                                }));
                              }),
                              profileItem(context, 'Terms and Conditions',
                                  IconsConstants.trems, () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WebviewScreen(
                                      url: value.data.terms!,
                                      title: 'Terms and Conditions');
                                }));
                              }),
                              profileItem(context, 'Privacy Policy',
                                  IconsConstants.privacy, () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WebviewScreen(
                                      url: value.data.privacy!,
                                      title: 'Privacy Policy');
                                }));
                              }),
                              const SizedBox(
                                height: 10,
                              ),
                              builderWidget(),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Profile',
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.20,
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(0.15000000596046448),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: appIcon(IconsConstants.close, false,
                                        context, 30, 30,
                                        color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
