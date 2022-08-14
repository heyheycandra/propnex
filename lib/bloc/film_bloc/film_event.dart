part of 'film_bloc.dart';

@immutable
abstract class FilmEvent {}

class SearchAll extends FilmEvent {
  final int? page;
  final String query;
  SearchAll({this.page, required this.query});
}

class SearchFilms extends FilmEvent {
  final int? page;
  final String query;
  SearchFilms({this.page, required this.query});
}

class GetFilmNP extends FilmEvent {
  final int? page;
  GetFilmNP({this.page});
}

class GetFilmPop extends FilmEvent {
  final int? page;
  GetFilmPop({this.page});
}

class GetFilmRecom extends FilmEvent {
  final int filmId;
  final int? page;

  GetFilmRecom(this.filmId, {this.page});
}

class GetFilmDetail extends FilmEvent {
  final String filmId;

  GetFilmDetail(this.filmId);
}
