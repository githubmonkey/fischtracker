import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_theme.g.dart';

@riverpod
class MyTheme extends _$MyTheme {
  MyTheme({this.scheme = FlexScheme.mango});

  final FlexScheme scheme;

  @override
  MyThemeState build() {
    return MyThemeState(
      theme: FlexThemeData.light(
        scheme: scheme,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useM2StyleDividerInM3: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: scheme,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useM2StyleDividerInM3: true,
          inputDecoratorBorderType: FlexInputBorderType.underline,
          inputDecoratorUnfocusedBorderIsColored: false,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      themeMode: ThemeMode.system, // Or any other default ThemeMode
    );
  }

  // If you do not have a themeMode switch, uncomment this line
  // to let the device system mode control the theme mode:
  // final themeMode = ThemeMode.system;
}

class MyThemeState {
  MyThemeState({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
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
  surface: Color(0xfffdfaf7),
  onSurface: Color(0xff090909),
  surfaceContainerHighest: Color(0xffebe7df),
  onSurfaceVariant: Color(0xff121211),
  outline: Color(0xff7c7c7c),
  outlineVariant: Color(0xffc8c8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
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
  surface: Color(0xff1b1914),
  onSurface: Color(0xffedecec),
  surfaceContainerHighest: Color(0xff433e35),
  onSurfaceVariant: Color(0xffe1e0df),
  outline: Color(0xff7d7676),
  outlineVariant: Color(0xff2e2c2c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xfffdfaf6),
  onInverseSurface: Color(0xff131313),
  inversePrimary: Color(0xff6e5a34),
  surfaceTint: Color(0xffdeb059),
);
