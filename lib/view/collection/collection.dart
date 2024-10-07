import 'dart:ui';

import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/services/local_storage.dart';
import 'package:coloring/utils/colors_utils.dart';
import 'package:coloring/utils/icons_constants.dart';
import 'package:coloring/utils/image_constants.dart';
import 'package:coloring/utils/utils.dart';
import 'package:coloring/view/game/game.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  ScreenshotController screenshotController = ScreenshotController();
  final DrawingController drawingController = DrawingController();
  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).loadmissiondone();
    super.initState();
  }

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
                  SafeArea(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.92,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const Expanded(flex: 1, child: SizedBox()),
                              //if no item in missiondone
                              if (value.missiondone.isEmpty) ...[
                                Expanded(
                                  flex: 6,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //icon
                                        Icon(
                                          Icons.collections,
                                          size: 50,
                                          color: hexToColor(
                                              value.data.mainColor.toString()),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'No item in collection',
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              Expanded(
                                flex: 6,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                                  clipBehavior: Clip.hardEdge,
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.9,
                                    ),
                                    itemCount: value.missiondone.length,
                                    itemBuilder: (context, index) {
                                      return DottedBorder(
                                        color: Colors.black.withOpacity(0.50),
                                        strokeWidth: 1,
                                        dashPattern: const [8, 8],
                                        borderType: BorderType.RRect,
                                        borderPadding: const EdgeInsets.all(8),
                                        radius: const Radius.circular(10),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              value.missiondone[
                                                                  index]),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      value.removemission(value
                                                          .missiondone[index]);
                                                    },
                                                    child: Container(
                                                      height: 29,
                                                      width: 29,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await LocalStorage
                                                          .loadDrawingFromLocal(
                                                              drawingController,
                                                              value.missiondone[
                                                                  index]);
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          title: const Text(
                                                              'Save to device'),
                                                          content: Screenshot(
                                                            controller:
                                                                screenshotController,
                                                            child: SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.3,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.7,
                                                              child:
                                                                  DrawingBoard(
                                                                controller:
                                                                    drawingController,
                                                                background:
                                                                    Container(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.3,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.7,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    image: DecorationImage(
                                                                        image: AssetImage(value.missiondone[
                                                                            index]),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      10,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                screenshotController
                                                                    .capture(
                                                                        delay: const Duration(
                                                                            milliseconds:
                                                                                10))
                                                                    .then(
                                                                        (capturedImage) async {
                                                                  //save image in gallery
                                                                  if (capturedImage !=
                                                                      null) {
                                                                    await saveImage(
                                                                        capturedImage,
                                                                        context);
                                                                  }
                                                                  showCapturedWidget(
                                                                          context,
                                                                          capturedImage!)
                                                                      .whenComplete(
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                }).catchError(
                                                                        (onError) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Failed to save in gallery',
                                                                        style: GoogleFonts
                                                                            .quicksand(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.7099999785423279),
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          letterSpacing:
                                                                              -0.20,
                                                                        ),
                                                                      ),
                                                                      backgroundColor: hexToColor(value
                                                                          .data
                                                                          .mainColor
                                                                          .toString()),
                                                                    ),
                                                                  );
                                                                });

                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    content:
                                                                        Text(
                                                                      'Saved in gallery',
                                                                      style: GoogleFonts
                                                                          .quicksand(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.7099999785423279),
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing:
                                                                            -0.20,
                                                                      ),
                                                                    ),
                                                                    backgroundColor: hexToColor(value
                                                                        .data
                                                                        .mainColor
                                                                        .toString()),
                                                                  ),
                                                                );
                                                              },
                                                              child: const Text(
                                                                'Save',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 29,
                                                      width: 29,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xff0FD717),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                        child: appIcon(
                                                          IconsConstants.save,
                                                          false,
                                                          context,
                                                          20,
                                                          20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              GamePage(
                                                            image: value
                                                                    .missiondone[
                                                                index],
                                                            isEdit: true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 29,
                                                      width: 29,
                                                      decoration: BoxDecoration(
                                                        color: hexToColor(value
                                                            .data.mainColor
                                                            .toString()),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Collection',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
