import 'package:convert/convert.dart';

String bytesToHex(List<int> bytes) => hex.encode(bytes);

List<int> hexToBytes(String hex) {
  hex = hex.toLowerCase();

  final regex = RegExp('[0-9a-f]{2}');

  return regex
      .allMatches(hex.toLowerCase())
      .map((Match match) => int.parse(match.group(0), radix: 16))
      .toList();
}
