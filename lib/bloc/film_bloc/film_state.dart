part of 'film_bloc.dart';

@immutable
abstract class FilmState {}

class FilmInitial extends FilmState {}

class FilmLoading extends FilmState {}

class LoadAll extends FilmState {
  final List<Movie> listFilms;
  LoadAll(this.listFilms);
}

class LoadFilmSearch extends FilmState {
  final List<Movie> listFilms;
  LoadFilmSearch(this.listFilms);
}

class FilmError extends FilmState {
  final String error;

  FilmError(this.error);
}

class LoadFilmNP extends FilmState {
  final List<Movie> listFilms;

  LoadFilmNP(this.listFilms);
}

class LoadFilmPop extends FilmState {
  final List<Movie> listFilms;

  LoadFilmPop(this.listFilms);
}

class LoadFilmRecom extends FilmState {
  final List<Movie> listFilms;

  LoadFilmRecom(this.listFilms);
}

class LoadFilmDetail extends FilmState {
  final Movie film;

  LoadFilmDetail(this.film);
}
