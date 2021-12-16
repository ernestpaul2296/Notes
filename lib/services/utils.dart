import 'dart:math' show Random;
import 'package:random_string/random_string.dart';

class Utils {
  static String getSecureString(int length) {
    Random r = Random.secure();
    return randomAlphaNumeric(length, provider: CoreRandomProvider.from(r));
  }
}
