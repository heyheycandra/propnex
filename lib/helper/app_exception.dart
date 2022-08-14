class AppException implements Exception {
  final dynamic message;
  final dynamic prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class RefreshTokenFailedException extends AppException {
  RefreshTokenFailedException([message]) : super(message, "Refresh Token Failed: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class InvalidSessionExpression extends AppException {
  InvalidSessionExpression([message]) : super(message, "Invalid Session: ");
}
