import 'package:convert/convert.dart';
import 'dart:math';

class Utils {
  static final Random _random = Random.secure();

  static String generateToken([int length = 32]) {
    var values = List<int>.generate(length, (i) => _random.nextInt(256));

    return hex.encode(values);
  }

  static int generateInt([int start = 1, int end = 9]) {
    return start + _random.nextInt(end - start);
  }
}
