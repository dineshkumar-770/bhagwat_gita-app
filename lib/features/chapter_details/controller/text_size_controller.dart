import 'package:flutter_riverpod/flutter_riverpod.dart';

final textAdjustProvider = StateNotifierProvider<TextSizeNotifier, double>((ref) {
  return TextSizeNotifier();
});

class TextSizeNotifier extends StateNotifier<double> {
  TextSizeNotifier() : super(0);

  void adjustTextSize(double fontSize) {
    state = fontSize;
  }
}
