import 'package:expensesly/pages/expenses_page.dart';
import 'package:flutter/material.dart';

var kColorSheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 43, 106, 34));
var kDarkColorSheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 50, 130, 42));
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
    colorScheme: kDarkColorSheme,
        appBarTheme: AppBarTheme(
            backgroundColor: kDarkColorSheme.primary,
            foregroundColor: kDarkColorSheme.onPrimary),
        cardTheme: CardTheme(
            
            shadowColor: kDarkColorSheme.outline,
            color: kDarkColorSheme.secondaryContainer,
            surfaceTintColor: kColorSheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorSheme.primaryContainer))),
    
    theme: ThemeData().copyWith(
        colorScheme: kColorSheme,
        appBarTheme: AppBarTheme(
            backgroundColor: kColorSheme.primary,
            foregroundColor: kColorSheme.onPrimaryContainer),
        cardTheme: CardTheme(
            
            shadowColor: kColorSheme.outline,
            color: kColorSheme.secondaryContainer,
            surfaceTintColor: kColorSheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorSheme.primaryContainer))),
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.system,
    home: const ExpensesPage(),
  ));
}
