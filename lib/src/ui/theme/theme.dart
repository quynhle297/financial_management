import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customTheme = ThemeData(
  textTheme: TextTheme(
    bodyLarge: GoogleFonts.roboto(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,  // Màu sắc cho bodyLarge
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black87,  // Màu sắc cho bodyMedium
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.black54,  // Màu sắc cho bodySmall
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey[800],  // Tiêu đề lớn
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.blueGrey[600],  // Tiêu đề vừa
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      color: Colors.grey[700],  // Nhãn nhỏ
    ),
  ),
);