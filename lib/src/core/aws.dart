import 'package:awsdart/src/core/http.dart';
import 'package:awsdart/src/core/signature.dart';
import 'package:awsdart/src/core/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class AWS {
  static Requester requester;

  Signature _sign;

  String accessKey;
  String secretKey;

  AWS({this.accessKey, this.secretKey}) {
    _sign = Signature(accessKey, secretKey);
  }

  Future<Response> request(Uri uri,
      {String method: 'GET',
      Map<String, String> headers,
      List<int> body,
      String region,
      String service,
      DateTime time,
      int signVersion: 4}) {
    var req = Request();

    req.uri = uri;
    req.method = method;

    if (headers != null) {
      req.headers.addAll(headers);
    }

    if (body != null) {
      req.body = body;
    }

    // Determine if the host header is set
    req.headers.putIfAbsent('Host', () => req.uri.host);

    // Set a datetime header if not set
    if (time == null) {
      time = DateTime.now().toUtc();
    }

    req.headers.putIfAbsent(
        'x-amz-date', () => DateFormat("yyyyMMddTHJHmmss'Z'").format(time));

    // Use the x-amz-content-sha256 if it is present
    if (!req.headers.containsKey('x-amz-content-sha256')) {
      var hash = sha256.convert(req.body).bytes;
      req.headers['x-amz-content-sha256'] = bytesToHex(hash);
    }

    //Sign the request.
    if (signVersion == 4) {
      if (region == null) {
        region = hostnameToRegion(req.uri.host);
      }
      if (service == null) {
        service = hostnameToService(req.uri.host);
      }

      req = _sign.sign4(req, service: service, region: region);
    } else {
      req = _sign.sign2(req);
    }

    return requester(req).then((res) {
      //logging
      var log = '${req.uri} ${res.statusCode} ${res.statusString}';
      print(log);

      return res;
    });
  }
}
