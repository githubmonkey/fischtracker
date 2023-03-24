import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_theme.g.dart';

@riverpod
class MyTheme extends _$MyTheme {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  final theme = FlexThemeData.light(
    scheme: FlexScheme.mango,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      //inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  final darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.mango,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 15,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      //inputDecoratorIsFilled: false,
      inputDecoratorBorderType: FlexInputBorderType.underline,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  // If you do not have a themeMode switch, uncomment this line
  // to let the device system mode control the theme mode:
  final themeMode = ThemeMode.system;
}

const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xffc78d20),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffdeb059),
  onPrimaryContainer: Color(0xff120f08),
  secondary: Color(0xff616247),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffbcbca8),
  onSecondaryContainer: Color(0xff10100e),
  tertiary: Color(0xff8d9440),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffbfc39b),
  onTertiaryContainer: Color(0xff10100d),
  error: Color(0xffb00020),
  onError: Color(0xffffffff),
  errorContainer: Color(0xfffcd8df),
  onErrorContainer: Color(0xff141213),
  background: Color(0xfffdfaf7),
  onBackground: Color(0xff090909),
  surface: Color(0xfffdfaf7),
  onSurface: Color(0xff090909),
  surfaceVariant: Color(0xfffbf6ef),
  onSurfaceVariant: Color(0xff131312),
  outline: Color(0xff565656),
  shadow: Color(0xff000000),
  inverseSurface: Color(0xff171511),
  onInverseSurface: Color(0xfff5f5f5),
  inversePrimary: Color(0xfffff8b9),
  surfaceTint: Color(0xffc78d20),
);

const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffdeb059),
  onPrimary: Color(0xff14110a),
  primaryContainer: Color(0xffc78d20),
  onPrimaryContainer: Color(0xfffff5e4),
  secondary: Color(0xff81816c),
  onSecondary: Color(0xfff9f9f7),
  secondaryContainer: Color(0xff5a5a35),
  onSecondaryContainer: Color(0xffedede8),
  tertiary: Color(0xffafb479),
  onTertiary: Color(0xff11120d),
  tertiaryContainer: Color(0xff82883d),
  onTertiaryContainer: Color(0xfff4f5e9),
  error: Color(0xffcf6679),
  onError: Color(0xff140c0d),
  errorContainer: Color(0xffb1384e),
  onErrorContainer: Color(0xfffbe8ec),
  background: Color(0xff1d1a15),
  onBackground: Color(0xffededec),
  surface: Color(0xff1d1a15),
  onSurface: Color(0xffededec),
  surfaceVariant: Color(0xff292319),
  onSurfaceVariant: Color(0xffdddcda),
  outline: Color(0xffa3a39d),
  shadow: Color(0xff000000),
  inverseSurface: Color(0xfffdfaf5),
  onInverseSurface: Color(0xff131313),
  inversePrimary: Color(0xff6f5b35),
  surfaceTint: Color(0xffdeb059),
);
