import 'package:awsdart/core.dart';
import 'package:test/test.dart';

import '../../../lib/io.dart';

void main() {
  test('Try and get google.com', () {
    var req = new Request();
    req.method = 'GET';
    req.uri = Uri.parse('https://google.com/');
    expect(
        ioRequester(req).then((res) {
          expect(res.statusCode, 200);
        }),
        completes);
  });
}
