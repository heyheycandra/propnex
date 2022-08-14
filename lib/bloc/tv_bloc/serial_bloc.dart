import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:technical_take_home/helper/app_exception.dart';
import 'package:technical_take_home/model/movie.dart';
import 'package:technical_take_home/services/restapi.dart';

part 'serial_event.dart';
part 'serial_state.dart';

class SerialBloc extends Bloc<SerialEvent, SerialState> {
  RestApi api = RestApi();
  SerialBloc() : super(SerialInitial()) {
    on<SerialEvent>((event, emit) async {
      try {
        if (event is SearchSerial) {
          List<Movie> listFilms = await tvSearch(event.page, event.query);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadSerialSearch(listFilms));
        } else if (event is GetSerialNP) {
          List<Movie> listFilms = await tvOnAir(event.page);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadSerialNP(listFilms));
        } else if (event is GetSerialPop) {
          List<Movie> listFilms = await tvPopular(event.page);
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadSerialPop(listFilms));
        } else if (event is GetSerialRecom) {
          List<Movie> listFilms = await tvRecom(
            event.page,
            event.tvId.toString(),
          );
          listFilms.removeWhere((e) =>
              e.id == null ||
              (e.title == null && e.name == null) ||
              ((e.posterPath?.toLowerCase().endsWith(".jpg") != true) && (e.posterPath?.toLowerCase().endsWith(".png") != true)));
          emit(LoadSerialRecom(listFilms));
        } else if (event is GetSerialDetail) {
          Movie film = await tvDetail(event.tvId);
          emit(LoadSerialDetail(film));
        }
      } catch (e) {
        emit(SerialError(e.toString()));
      }
    });
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
        model.strId = model.id.toString() + "tvSearch";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> tvOnAir(int? page) async {
    List<Movie> listReturn = [];
    var response = await api.tvOnAir(param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "tvOnAir";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> tvPopular(int? page) async {
    List<Movie> listReturn = [];
    var response = await api.tvPopular(param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "tvPop";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<List<Movie>> tvRecom(int? page, String id) async {
    List<Movie> listReturn = [];
    var response = await api.tvRecom(tvId: id, param: {
      "page": (page ?? 1).toString(),
    }) as Map;

    List? result = response['results'];
    if (result == null) {
      throw FetchDataException('Error occured while fetching data');
    } else {
      for (var element in result) {
        Movie model = Movie.map(element);
        model.strId = model.id.toString() + "tvRecom";
        listReturn.add(model);
      }
    }
    return listReturn;
  }

  Future<Movie> tvDetail(String id) async {
    var response = await api.tvDetail(tvId: id) as Map;

    return Movie.map(response);
  }
}
