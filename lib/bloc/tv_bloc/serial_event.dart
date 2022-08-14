part of 'serial_bloc.dart';

@immutable
abstract class SerialEvent {}

class SearchSerial extends SerialEvent {
  final int? page;
  final String query;
  SearchSerial({this.page, required this.query});
}

class GetSerialNP extends SerialEvent {
  final int? page;
  GetSerialNP({this.page});
}

class GetSerialPop extends SerialEvent {
  final int? page;
  GetSerialPop({this.page});
}

class GetSerialRecom extends SerialEvent {
  final int? page;
  final String tvId;

  GetSerialRecom(this.tvId, {this.page});
}

class GetSerialDetail extends SerialEvent {
  final String tvId;

  GetSerialDetail(this.tvId);
}
