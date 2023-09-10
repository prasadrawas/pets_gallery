import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle extraLight({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w200,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle light({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w300,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle regular({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.normal,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle medium({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle bold({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: color,
      fontSize: fontSize,
    );
  }

  static TextStyle extraBold({
    Color? color,
    double? fontSize,
  }) {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w800,
      color: color,
      fontSize: fontSize,
    );
  }
}
