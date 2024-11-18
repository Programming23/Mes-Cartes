import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  fontFamily: 'main',
  scaffoldBackgroundColor: Colors.grey[280],

  // Theme of Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      primary: Colors.blue[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  ),
  textTheme: TextTheme(

      // الثيم الخاص بنص الجهات في صفحة البطاقة
      headlineLarge: TextStyle(
        fontSize: 18, // حجم النص.
        fontWeight: FontWeight.bold, // الوزن الثقيل للنص.
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      // Text Of Search Texts
      displayMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      // Title of flashCard Set
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      // Theme of hint of inputs
      labelLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      // Listtile Texts
      labelSmall: TextStyle(
        fontSize: 15,
        letterSpacing: 0.4,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      // Theme of Popup Menu Items (button of "حذف" و "تعديل")
      labelMedium: TextStyle(
        fontSize: 14,
        color: Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      //theme of inputs and back of flashcard
      bodyMedium: TextStyle(
        fontSize: 15.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      // Category of FlashCard Set
      bodySmall: TextStyle(
        fontSize: 17,
        color: Colors.grey[600],
      ),
      // Theme of about us text
      bodyLarge: TextStyle(
        fontSize: 14,
        color: Colors.grey[600],
      )),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue[900],
  ),
);
