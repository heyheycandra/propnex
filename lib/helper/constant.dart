import 'package:flutter/material.dart';

class Constant extends InheritedWidget {
  static Constant? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Constant>();

  const Constant({required Widget child, Key? key}) : super(key: key, child: child);

  //MENUS
  static const String menuHome = "MENU_HOME";
  static const String menuFilm = "MENU_FILM";
  static const String menuFilmNP = "MENU_FILM_NP";
  static const String menuFilmPop = "MENU_FILM_POP";
  static const String menuSeries = "MENU_SERIES";
  static const String menuDetails = "MENU_DETAILS";
  static const String menuSeriesNP = "MENU_SERIES_NP";
  static const String menuSeriesPop = "MENU_SERIES_POP";
  //FORMS

  //for API
  static const apiKey = "fbb9572d11b5458ac98f02b84f2bafc4";
  static const imageUrl = "https://image.tmdb.org/t/p/w500/";

  //form Mode

  //Actions

  //settings

  @override
  bool updateShouldNotify(Constant oldWidget) => false;
}
