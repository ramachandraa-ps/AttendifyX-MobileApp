import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 28.0  ,
    fontWeight: FontWeight.bold,
    color: Colors.black, // Customize color as needed
    fontFamily: 'Times New Roman', // Use custom font
  );

  static final TextStyle headline2 = GoogleFonts.poppins(
    fontSize: 28.0,
    fontWeight: FontWeight.w600,
    color: Colors.black
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    fontFamily: 'New Amsterdam', // Use custom font
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    fontFamily: 'New Amsterdam',
  );
}
