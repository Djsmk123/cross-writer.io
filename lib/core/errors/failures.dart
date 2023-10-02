import 'package:blogtools/core/errors/exceptions.dart';

class ServerException implements Exception {}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message = 'Server Failure'});
}

class InternetFailure extends Failure {
  final String message;
  InternetFailure({this.message = "No Internet Connection"});
}

class EndpointFailure extends Failure {
  final String message;
  EndpointFailure({required this.message});
}

class JsonFailure extends Failure {}

class CustomErrorFailure extends Failure {
  final String message;
  CustomErrorFailure({required this.message});
}

class TimeoutFailure extends Failure {}

String getErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Internal Server Error';
    case InternetFailure:
      return 'Check your internet connection';
    case EndpointFailure:
      return (failure as EndpointFailure).message;
    case JsonFailure:
      return 'Internal Server Error';
    case TimeoutFailure:
      return 'Timeout Occurred!!';
    case CustomErrorFailure:
      return (failure as CustomErrorFailure).message;
    default:
      return 'Something went wrong';
  }
}
