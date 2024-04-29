
class AppExceptions implements Exception{
  final String? _prefix;
  final String? _message;

  AppExceptions([this._prefix, this._message]);

  @override
  String toString(){
    return '$_prefix$_message';
  }
}


class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'Internet Error Issue');

}


class RequestTimeOut extends AppExceptions{
  RequestTimeOut([String? message]) : super(message, 'The request has timed out');
}


class ServerError extends AppExceptions{
  ServerError([String? message]) : super(message, 'An internal server error occured');
}

class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]) : super(message, 'The URL provided is invalid');
}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]) : super(message, 'Failed to fetch data from the server');
}

