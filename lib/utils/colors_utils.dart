import 'package:flutter/material.dart';

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) {
    // Return a default color if hex is null or empty
    return Colors.black; // Or any other default color you prefer
  }
  // Remove any leading "#" if present
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // Add alpha channel if not present
  }
  try {
    return Color(int.parse(hex, radix: 16));
  } catch (e) {
    // Handle parsing error, return a default color
    return Colors.black; // Or another default color
  }
}
