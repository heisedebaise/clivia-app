import 'dart:core';
import 'dart:math';

class Generator {
  static final Random _random = Random(DateTime.now().millisecondsSinceEpoch);
  static const String _chars = 'qwertyuioplkjhgfdsazxcvbnm0123456789MNBVCXZASDFGHJKLPOIUYTREWQ';

  static String string(int length) {
    String string = '';
    while (string.length < length) {
      int n = _random.nextInt(61);
      string += _chars.substring(n, n + 1);
    }

    return string;
  }

  static int range(int min, int max) {
    return _random.nextInt(max - min) + min;
  }
}
