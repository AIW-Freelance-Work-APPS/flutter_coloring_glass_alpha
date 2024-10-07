import 'dart:math';
import 'dart:ui';
import 'package:coloring/model_view/data_provider.dart';
import 'package:coloring/services/local_storage.dart';
import 'package:coloring/utils/colors_utils.dart';
import 'package:coloring/utils/icons_constants.dart';
import 'package:coloring/utils/image_constants.dart';
import 'package:coloring/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:screenshot/screenshot.dart';

import 'package:flutter/services.dart';

class GamePage extends StatefulWidget {
  final String image;
  final bool isEdit;
  const GamePage({super.key, required this.image, required this.isEdit});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final DrawingController drawingController = DrawingController();
  int selectedColor = 0;
  bool isSaved = false;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    if (widget.isEdit) {
      LocalStorage.loadDrawingFromLocal(drawingController, widget.image);
    }
    drawingController.addListener(() {
      setState(() {});
    });

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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
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
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      color: Colors.white,
                      child: GridView.builder(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 16,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              drawingController.setStyle(
                                  color: Colors.primaries[
                                      index % Colors.primaries.length],
                                  strokeWidth: 5);

                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  border: selectedColor == index
                                      ? Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        )
                                      : null,
                                  color: Colors.primaries[index %
                                      Colors.primaries
                                          .length], // Use random colors
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: Colors.black.withOpacity(0.5),
                      radius: const Radius.circular(8),
                      padding: const EdgeInsets.all(8),
                      dashPattern: const [8, 8],
                      child: Screenshot(
                        controller: screenshotController,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: DrawingBoard(
                            controller: drawingController,
                            background: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(widget.image),
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () async {
                                    //dailog loading
                                    if (drawingController.canUndo()) {
                                      if (value.missiondone
                                          .contains(widget.image)) {
                                        await value.removemission(widget.image);
                                      }
                                      await value.savemissiondone(
                                          drawingController, widget.image);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Saved',
                                            style: GoogleFonts.quicksand(
                                              color: Colors.black.withOpacity(
                                                  0.7099999785423279),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                          backgroundColor: hexToColor(
                                              value.data.mainColor.toString()),
                                        ),
                                      );
                                      setState(() {
                                        isSaved = true;
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please draw something',
                                            style: GoogleFonts.quicksand(
                                              color: Colors.black.withOpacity(
                                                  0.7099999785423279),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    width: 84,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: hexToColor(
                                          value.data.mainColor.toString()),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Done',
                                        style: GoogleFonts.quicksand(
                                          color: Colors.black
                                              .withOpacity(0.7099999785423279),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isSaved) ...[
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  //download
                                  InkWell(
                                    borderRadius: BorderRadius.circular(30),
                                    onTap: () async {
                                      screenshotController
                                          .capture(
                                              delay: const Duration(
                                                  milliseconds: 10))
                                          .then((capturedImage) async {
                                        //save image in gallery
                                        if (capturedImage != null) {
                                          await saveImage(
                                              capturedImage, context);
                                        }
                                        showCapturedWidget(
                                            context, capturedImage!);
                                      }).catchError((onError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to save in gallery',
                                              style: GoogleFonts.quicksand(
                                                color: Colors.black.withOpacity(
                                                    0.7099999785423279),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: -0.20,
                                              ),
                                            ),
                                            backgroundColor: hexToColor(value
                                                .data.mainColor
                                                .toString()),
                                          ),
                                        );
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Saved in gallery',
                                            style: GoogleFonts.quicksand(
                                              color: Colors.black.withOpacity(
                                                  0.7099999785423279),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.20,
                                            ),
                                          ),
                                          backgroundColor: hexToColor(
                                              value.data.mainColor.toString()),
                                        ),
                                      );
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
                                        child: appIcon(IconsConstants.save,
                                            false, context, 30, 30,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    drawingController.clear();
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
                                      child: appIcon(IconsConstants.restart,
                                          false, context, 30, 30,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    drawingController.undo();
                                    setState(() {});
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
                                        child: appIcon(IconsConstants.undo,
                                            false, context, 30, 30,
                                            color: drawingController.canUndo()
                                                ? Colors.white
                                                : Colors.white
                                                    .withOpacity(0.3)),
                                      )),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    drawingController.redo();
                                    setState(() {});
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
                                      child: appIcon(IconsConstants.redo, false,
                                          context, 30, 30,
                                          color: drawingController.canRedo()
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.3)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () {
                                if (!isSaved) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Are you sure?'),
                                      content: const Text(
                                          'You have unsaved changes. Do you want to leave?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Leave',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                }
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
                                ),
                              ),
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

Future<dynamic> showCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title:
            const Text("Captured Image", style: TextStyle(color: Colors.black)),
      ),
      body: Center(child: Image.memory(capturedImage)),
    ),
  );
}

Future<void> saveImage(Uint8List imageBytes, BuildContext context) async {
  String imageName = generateRandomImageName();
  final result = await ImageGallerySaverPlus.saveImage(
    imageBytes,
    quality: 100, // Image quality
    name: imageName, // Random name for the saved image
  );

  if (result['isSuccess']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image saved as $imageName to gallery')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save image')),
    );
  }
}

String generateRandomImageName() {
  final now = DateTime.now();
  final random = Random();
  return 'IMG_${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}_${random.nextInt(10000)}';
}
