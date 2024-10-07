import 'package:coloring/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InkWell homeItems(BuildContext context, String title, String description,
    String icon, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 23),
      height: 116,
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1C000000),
            blurRadius: 50,
            offset: Offset(0, 0),
            spreadRadius: 0,
            blurStyle: BlurStyle.inner,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.60,
                  child: Text(
                    title,
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.40,
                  child: Text(
                    description,
                    style: GoogleFonts.quicksand(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.15,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 82,
              height: 82,
              decoration: ShapeDecoration(
                color: const Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Center(
                child:
                    appIcon(icon, false, context, 51, 51, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
