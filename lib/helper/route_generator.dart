import 'package:flutter/material.dart';
import 'package:technical_take_home/helper/constant.dart';
import 'package:technical_take_home/helper/locator.dart';
import 'package:technical_take_home/helper/navigator_service.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/shared_widgets/custom_snack_bar.dart';
import 'package:technical_take_home/shared_widgets/nav_header.dart';
import 'package:technical_take_home/ui/detail/movie_detail.dart';
import 'package:technical_take_home/ui/detail/series_detail.dart';
import 'package:technical_take_home/ui/flms/film_screen.dart';
import 'package:technical_take_home/ui/flms/now_showing/now_showing_screen.dart';
import 'package:technical_take_home/ui/flms/popular/popular_screen.dart';
import 'package:technical_take_home/ui/home/home_screen.dart';
import 'package:technical_take_home/ui/series/on_air/on_air_screen.dart';
import 'package:technical_take_home/ui/series/popular/popular_screen.dart';
import 'package:technical_take_home/ui/series/series_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constant.menuHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Constant.menuDetails:
        try {
          Movie film = settings.arguments as Movie;
          if (film.title != null) {
            return MaterialPageRoute(builder: (_) => FilmDetail(model: film));
          } else if (film.name != null) {
            return MaterialPageRoute(builder: (_) => SerialDetail(model: film));
          } else {
            return _errorRoute(message: "Couldn't get this movie detail");
          }
        } catch (e) {
          return _errorRoute(message: "Couldn't get this movie detail");
        }
      case Constant.menuFilm:
        return MaterialPageRoute(builder: (_) => const FilmScreen());
      case Constant.menuFilmNP:
        return MaterialPageRoute(builder: (_) => const NowShowingScreen());
      case Constant.menuFilmPop:
        return MaterialPageRoute(builder: (_) => const PopularScreen());
      case Constant.menuSeries:
        return MaterialPageRoute(builder: (_) => const SerialScreen());
      case Constant.menuSeriesNP:
        return MaterialPageRoute(builder: (_) => const OnAirScreen());
      case Constant.menuSeriesPop:
        return MaterialPageRoute(builder: (_) => const PopularSerialScreen());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute(message: "Couldn't get this screen");
    }
  }

  static Route<dynamic> _errorRoute({String? message}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: navHeader('Error'),
        body: Builder(builder: (context) {
          if (message != null) {
            error(context, message);
          }
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Ups, Something went wrong. Please click this button"),
              Container(
                margin: const EdgeInsets.all(4),
              ),
              GestureDetector(
                  onTap: () {
                    locator<NavigatorService>().navigateReplaceTo(Constant.menuHome);
                  },
                  child: const Icon(Icons.refresh_outlined))
            ],
          ));
        }),
      );
    });
  }
}
