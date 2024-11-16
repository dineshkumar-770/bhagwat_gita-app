import 'dart:io';

import 'package:bhagwat_gita/features/text_to_speech/controller/text_to_speech_controller.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapter_state.dart';
import 'package:bhagwat_gita/features/verses/service/verses.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chapterVerseProvider = StateNotifierProvider.autoDispose<ChapterVerseNotifier, ChapterVerseState>((ref) {
  return ChapterVerseNotifier(verseRepositary: ref.read(verseRepositaryProvider));
});

class ChapterVerseNotifier extends StateNotifier<ChapterVerseState> {
  ChapterVerseNotifier({required this.verseRepositary}) : super(ChapterVerseState.init());

  VerseRepositary verseRepositary;

  Future<void> fetchChaptersVerse(int chapterNumber) async {
    state = state.copyWith(verseLoading: true, errorMessage: "");
    try {
      final data = await verseRepositary.fetchVersesChapterWise(chapterNumber: chapterNumber);
      if (data.isNotEmpty) {
        state = state.copyWith(verseLoading: false, chapterVerseList: data, errorMessage: "");
      } else {
        state = state.copyWith(errorMessage: 'No verse available at this moment');
      }
    } on SocketException catch (e) {
      state = state.copyWith(errorMessage: 'No verse available at this moment! error:- ${e.message}');
    }
  }

  Future<void> speakHindiTTS(String text, int index) async {
    state = state.copyWith(currentTTSIndex: index);
    await TextToSpeechService.instance.stop();
    state = state.copyWith(isSpeaking: true);
    await TextToSpeechService.instance.speakHindi(text: text);
    state = state.copyWith(isSpeaking: false);
  }

  Future<void> stopSpeaking() async {
    await TextToSpeechService.instance.stop();
    state = state.copyWith(isSpeaking: false);
  }

  @override
  void dispose() {
    TextToSpeechService.instance.stop();
    super.dispose();
  }
}
