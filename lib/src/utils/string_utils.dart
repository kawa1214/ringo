import 'dart:convert';

import 'dart:typed_data';

class StringUtils {
  static Uint8List stringToUint8List(String string) {
    final encoder = Utf8Encoder();
    return encoder.convert(string);
  }

  static String uint8ListToString(List<int> bytes) {
    return Utf8Decoder().convert(bytes);
  }
}
