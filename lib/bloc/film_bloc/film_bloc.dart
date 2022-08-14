import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:technical_take_home/helper/app_exception.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/services/restapi.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  RestApi api = RestApi();
  FilmBloc() : super(FilmInitial()) {
    on<FilmEvent>((event, emit) async {
      emit(FilmLoading());
      try {
        if (event is SearchAll) {
          List<Movie> listMovies = await movieSearch(event.page, event.query);
          List<Movie> listTvs = await tvSearch(event.page, event.query);
          List<Movie> listFilms = [...listMovies, ...listTvs];
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadAll(listFilms));
        } else if (event is SearchFilms) {
          List<Movie> listFilms = await movieSearch(event.page, event.query);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadFilmSearch(listFilms));
        } else if (event is GetFilmNP) {
          List<Movie> listFilms = await movieNowPlaying(event.page);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadFilmNP(listFilms));
        } else if (event is GetFilmPop) {
          List<Movie> listFilms = await moviePopular(event.page);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadFilmPop(listFilms));
        } else if (event is GetFilmRecom) {
          List<Movie> listFilms = await movieRecom(
            event.page,
            event.filmId.toString(),
          );
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadFilmRecom(listFilms));
        } else if (event is GetFilmDetail) {
          Movie film = await movieDetail(event.filmId);
          emit(LoadFilmDetail(film));
        }
      } catch (e) {
        emit(FilmError(e.toString()));
      }
    });
  }

  Future<List<Movie>> movieSearch(int? page, String searchVal) async {
    List<Movie> listReturn = [];
    var response = await api.movieSearch(param: {
      "query": searchVal,
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "filmSearch";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> movieNowPlaying(int? page) async {
    List<Movie> listReturn = [];
    var response = await api.movieNowPlaying(param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "filmNP";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> moviePopular(int? page) async {
    List<Movie> listReturn = [];
    var response = await api.moviePopular(param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "filmPop";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> movieRecom(int? page, String id) async {
    List<Movie> listReturn = [];
    var response = await api.movieRecom(movieId: id, param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "filmRecom";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<Movie> movieDetail(String id) async {
    var response = await api.movieDetail(movieId: id) as Map;

    return Movie.map(response);
  }

  Future<List<Movie>> tvSearch(int? page, String searchVal) async {
    List<Movie> listReturn = [];
    var response = await api.tvSearch(param: {
      "query": searchVal,
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "filmTvSearch";
        listReturn.add(model);
      }
    }
    return listReturn;
  }
}
