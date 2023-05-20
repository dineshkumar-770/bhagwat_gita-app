// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

final textToSpeechProvider =
    StateNotifierProvider<TextToSpeechNotifier, TextToSpeechState>((ref) {
  return TextToSpeechNotifier();
});

class TextToSpeechNotifier extends StateNotifier<TextToSpeechState> {
  TextToSpeechNotifier() : super(TextToSpeechState.init());

  FlutterTts flutterTts = FlutterTts();

  Future<void> speakHindi({required String text}) async {
    final isAvailable = await flutterTts.isLanguageAvailable('hi');
    if (isAvailable == true) {
      state = state.copyWith(speakingHindi: true, speakingEnglish: false);
      await flutterTts.setLanguage(const Locale('hi').languageCode);
      await flutterTts.setPitch(1); // Lower pitch for deeper voice
      await flutterTts.setSpeechRate(0.4); // Slightly slower speech rate
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
      state = state.copyWith(speakingHindi: false, speakingEnglish: false);
    } else {
      Fluttertoast.showToast(
          msg: 'Language module is available on your phone!');
    }
  }

  Future<void> speakEnglish({required String text}) async {
    state = state.copyWith(speakingEnglish: true, speakingHindi: false);
    await flutterTts.setLanguage('en');
    await flutterTts.setPitch(0.8); // Lower pitch for deeper voice
    await flutterTts.setSpeechRate(0.4); // Slightly slower speech rate
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true).then((value) {
      state = state.copyWith(speakingEnglish: false, speakingHindi: false);
    });
  }

  void stop() {
    flutterTts.stop();
    state = state.copyWith(speakingEnglish: false, speakingHindi: false);
  }

}

class TextToSpeechState extends Equatable {
  final bool speakingHindi;
  final bool speakingEnglish;
  const TextToSpeechState({
    required this.speakingHindi,
    required this.speakingEnglish,
  });

  factory TextToSpeechState.init() {
    return const TextToSpeechState(
        speakingEnglish: false, speakingHindi: false);
  }

  @override
  List<Object?> get props => [speakingEnglish, speakingHindi];

  TextToSpeechState copyWith({
    bool? speakingHindi,
    bool? speakingEnglish,
  }) {
    return TextToSpeechState(
      speakingHindi: speakingHindi ?? this.speakingHindi,
      speakingEnglish: speakingEnglish ?? this.speakingEnglish,
    );
  }
}
