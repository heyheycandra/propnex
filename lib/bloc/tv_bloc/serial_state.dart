part of 'serial_bloc.dart';

@immutable
abstract class SerialState {}

class SerialInitial extends SerialState {}

class SerialLoading extends SerialState {}

class LoadSerialSearch extends SerialState {
  final List<Movie> listFilms;
  LoadSerialSearch(this.listFilms);
}

class SerialError extends SerialState {
  final String error;

  SerialError(this.error);
}

class LoadSerialNP extends SerialState {
  final List<Movie> listSerials;

  LoadSerialNP(this.listSerials);
}

class LoadSerialPop extends SerialState {
  final List<Movie> listSerials;

  LoadSerialPop(this.listSerials);
}

class LoadSerialRecom extends SerialState {
  final List<Movie> listSerials;

  LoadSerialRecom(this.listSerials);
}

class LoadSerialDetail extends SerialState {
  final Movie serial;

  LoadSerialDetail(this.serial);
}
