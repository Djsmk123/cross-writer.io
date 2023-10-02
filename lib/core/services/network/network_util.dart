class HttpParam {
  final Map<String, dynamic> params;
  HttpParam({this.params = const {}});
  call() {
    return params;
  }
}

class HttpHeader {
  final Map<String, String> headers;
  HttpHeader(
      {this.headers = const {
        'Content-Type': 'application/json',
      }});
}

class QueryParam {
  final Map<String, dynamic> params;
  QueryParam({this.params = const {}});
  call() {
    return params;
  }
}
