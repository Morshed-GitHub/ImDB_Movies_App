// Implements -> Abstract Base Class, Consist Empty/ Abstract Method
// Best practice to "implements" from "Exception" Abstract Base Class
class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix: $_message";
  }
}

// Extends -> Inheritance
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, "Invalid Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, "Unauthorised Request");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input");
}
