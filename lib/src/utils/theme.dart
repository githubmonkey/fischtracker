import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = Provider((ref) => _theme);
final darkTheme = Provider((ref) => _darkTheme);

// This theme was made for FlexColorScheme version 6.1.1. Make sure
// you use same or higher version, but still same major version. If
// you use a lower version, some properties may not be supported. In
// that case you can also remove them after copying the theme to your app.
final _theme = FlexThemeData.light(
  scheme: FlexScheme.mango,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 9,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    //inputDecoratorIsFilled: false,
    //inputDecoratorBorderType: FlexInputBorderType.underline,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
);

final _darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.amber,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 15,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    //inputDecoratorIsFilled: false,
    //inputDecoratorBorderType: FlexInputBorderType.underline,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  fontFamily: GoogleFonts.notoSans().fontFamily,
);

const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xffe65100),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffffcc80),
  onPrimaryContainer: Color(0xff14110b),
  secondary: Color(0xff2979ff),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffe4eaff),
  onSecondaryContainer: Color(0xff131314),
  tertiary: Color(0xff2962ff),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffcbd6ff),
  onTertiaryContainer: Color(0xff111214),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  background: Color(0xfffef8f6),
  onBackground: Color(0xff090909),
  surface: Color(0xfffef8f6),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xfffdf2ed),
  onSurfaceVariant: Color(0xff131212),
  outline: Color(0xff565656),
  shadow: Color(0xff000000),
  inverseSurface: Color(0xff181310),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xffffcf99),
  surfaceTint: Color(0xffe65100),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffb300),
  onPrimary: Color(0xff141204),
  primaryContainer: Color(0xffc87200),
  onPrimaryContainer: Color(0xfffff1df),
  secondary: Color(0xff82b1ff),
  onSecondary: Color(0xff0e1114),
  secondaryContainer: Color(0xff3770cf),
  onSecondaryContainer: Color(0xffe8f1ff),
  tertiary: Color(0xff448aff),
  onTertiary: Color(0xfff4f9ff),
  tertiaryContainer: Color(0xff0b429c),
  onTertiaryContainer: Color(0xffe1eaf8),
  error: Color(0xffcf6679),
  onError: Color(0xff140c0d),
  errorContainer: Color(0xffb1384e),
  onErrorContainer: Color(0xfffbe8ec),
  background: Color(0xff1f1a10),
  onBackground: Color(0xffededec),
  surface: Color(0xff1f1a10),
  onSurface: Color(0xffededec),
  surfaceVariant: Color(0xff2d240f),
  onSurfaceVariant: Color(0xffdedcd9),
  outline: Color(0xffa3a39d),
  shadow: Color(0xff000000),
  inverseSurface: Color(0xfffffaf0),
  onInverseSurface: Color(0xff141312),
  inversePrimary: Color(0xff785c0e),
  surfaceTint: Color(0xffffb300),
  //foo: Color(0xf23b1400),
);
