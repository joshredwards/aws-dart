typedef Future<Response> Requester(Request req);

class Request {
  String method = 'GET';
  Uri uri = Uri();
  Map<String, String> headers = {};
  List<int> body = [];
}

class Response {
  int statusCode = 0;
  String statusString = '';
  Map<String, String> headers = {};
  List<int> body = [];
}
