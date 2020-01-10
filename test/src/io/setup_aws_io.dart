import 'package:test/test.dart';

import '../../../lib/io.dart';

void main() {
  test('sets Aws.requester to ioRequester', () {
    // Setup
    AWS.requester = null;

    // Action
    setupAWSIO();

    // Assertions
    expect(AWS.requester, same(ioRequester));

    // Clean up
    AWS.requester = null;
  });
}
