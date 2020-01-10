import 'package:awsdart/src/core/utils.dart';
import 'package:test/test.dart';

void main() {
  test('bytesToHex => hexToBytes round trip', () {
    var bytes0_255 = new List.generate(256, (i) => i);
    var hex = bytesToHex(bytes0_255);
    expect(hexToBytes(hex), bytes0_255);
  });
}
