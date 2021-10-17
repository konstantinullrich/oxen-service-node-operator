import 'package:flutter/material.dart';

import 'palette.dart';

class Themes {
  static final ThemeData lightTheme = ThemeData(
      fontFamily: 'Lato',
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      hintColor: Palette.lightBlue,
      focusColor: Palette.lightGrey,
      primaryTextTheme: TextTheme(
          headline6: TextStyle(color: OxenPalette.black),
          caption: TextStyle(
            color: OxenPalette.black,
          ),
          button: TextStyle(
              color: OxenPalette.black,
              backgroundColor: OxenPalette.tealWithOpacity,
              decorationColor: OxenPalette.teal),
          headline5: TextStyle(color: OxenPalette.black),
          subtitle2: TextStyle(color: Palette.wildDarkBlue),
          subtitle1: TextStyle(color: OxenPalette.black),
          overline: TextStyle(color: PaletteDark.darkThemeCloseButton)),
      toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: OxenPalette.teal,
          disabledColor: Palette.wildDarkBlue,
          color: Palette.switchBackground,
          borderColor: Palette.switchBorder),
      selectedRowColor: OxenPalette.tealWithOpacity,
      dividerColor: Palette.lightGrey,
      dividerTheme: DividerThemeData(color: Palette.lightGrey),
      accentTextTheme: TextTheme(
          headline6: TextStyle(
              color: Colors.grey, backgroundColor: Palette.creamyGrey),
          caption: TextStyle(
              color: Palette.wildDarkBlue,
              backgroundColor: Palette.brightBlue,
              decorationColor: Palette.cloudySky),
          button: TextStyle(
              backgroundColor: Palette.indigo,
              decorationColor: Palette.deepIndigo),
          subtitle2: TextStyle(
              color: OxenPalette.black, backgroundColor: Palette.lightLavender),
          headline5: TextStyle(
            color: Palette.lightGrey2,
            backgroundColor: Colors.white,
            decorationColor: Palette.darkGrey,
          ),
          subtitle1: TextStyle(
              color: Palette.lightBlue, backgroundColor: Palette.lightGrey2),
          overline: TextStyle(
              color: OxenPalette.blue,
              backgroundColor: OxenPalette.blue,
              decorationColor: Palette.manatee)),
      buttonTheme: ButtonThemeData(
        buttonColor: Palette.darkGrey
      ),
      primaryIconTheme: IconThemeData(color: Colors.white),
      accentIconTheme: IconThemeData(color: Colors.white));

  static final ThemeData darkTheme = ThemeData(
      fontFamily: 'Lato',
      brightness: Brightness.dark,
      backgroundColor: PaletteDark.darkThemeBackgroundDark,
      scaffoldBackgroundColor: PaletteDark.darkThemeBlack,
      hintColor: PaletteDark.darkThemeGrey,
      focusColor: PaletteDark.darkThemeGreyWithOpacity,
      primaryTextTheme: TextTheme(
          headline6: TextStyle(color: PaletteDark.darkThemeTitle),
          caption: TextStyle(color: Colors.white),
          button: TextStyle(
              color: Palette.wildDarkBlue,
              backgroundColor: OxenPalette.tealWithOpacity,
              decorationColor: OxenPalette.teal),
          headline5: TextStyle(color: PaletteDark.darkThemeGrey),
          subtitle2: TextStyle(color: PaletteDark.darkThemeGrey),
          subtitle1: TextStyle(color: Palette.blueGrey),
          overline: TextStyle(color: PaletteDark.darkThemeGrey)),
      toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: OxenPalette.teal,
          disabledColor: Palette.wildDarkBlue,
          color: PaletteDark.switchBackground,
          borderColor: PaletteDark.darkThemeMidGrey),
      selectedRowColor: OxenPalette.tealWithOpacity,
      dividerColor: PaletteDark.darkThemeDarkGrey,
      dividerTheme:
          DividerThemeData(color: PaletteDark.darkThemeGreyWithOpacity),
      accentTextTheme: TextTheme(
          headline6: TextStyle(
              color: PaletteDark.darkThemeTitle,
              backgroundColor: PaletteDark.darkThemePinDigitButton),
          caption: TextStyle(
              color: PaletteDark.darkThemeTitleViolet,
              backgroundColor: PaletteDark.darkThemeBlueButton,
              decorationColor: PaletteDark.darkThemeBlueButtonBorder),
          button: TextStyle(
              backgroundColor: PaletteDark.darkThemeIndigoButton,
              decorationColor: PaletteDark.darkThemeIndigoButtonBorder),
          subtitle2: TextStyle(
              color: PaletteDark.wildDarkBlueWithOpacity,
              backgroundColor: PaletteDark.darkThemeDarkGrey),
          headline5: TextStyle(
            color: PaletteDark.darkThemeBlack,
            backgroundColor: PaletteDark.darkThemeMidGrey,
            decorationColor: PaletteDark.darkThemeDarkGrey,
          ),
          subtitle1: TextStyle(
              color: Palette.wildDarkBlue,
              backgroundColor: PaletteDark.darkThemeMidGrey),
          overline: TextStyle(
              color: PaletteDark.darkThemeTitle,
              backgroundColor: PaletteDark.darkThemeGrey,
              decorationColor: PaletteDark.darkThemeTitle)),
      buttonTheme: ButtonThemeData(
        buttonColor: PaletteDark.darkThemePinButton
      ),
      primaryIconTheme: IconThemeData(color: PaletteDark.darkThemeViolet),
      accentIconTheme:
          IconThemeData(color: PaletteDark.darkThemeIndigoButtonBorder));
}
