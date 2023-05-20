import 'dart:io';

import 'package:bhagwat_gita/features/verses/controller/verse_from_chapter_state.dart';
import 'package:bhagwat_gita/features/verses/service/verses.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chapterVerseProvider =
    StateNotifierProvider<ChapterVerseNotifier, ChapterVerseState>((ref) {
  return ChapterVerseNotifier(
      verseRepositary: ref.read(verseRepositaryProvider));
});

class ChapterVerseNotifier extends StateNotifier<ChapterVerseState> {
  ChapterVerseNotifier({required this.verseRepositary})
      : super(ChapterVerseInitialState());

  VerseRepositary verseRepositary;

  Future<void> fetchChaptersVerse(int chapterNumber) async {
    state = ChapterVerseLoadingState();
    try {
      final data = await verseRepositary.fetchVersesChapterWise(
          chapterNumber: chapterNumber);
      if (data.isNotEmpty) {
        state = ChapterVerseSuccessState(chapterVerseList: data);
      } else {
        state = ChapterVerseErrorState(
            errorMessage: 'No verse available at this moment!');
      }
    } on SocketException catch (e) {
      state = ChapterVerseErrorState(
          errorMessage:
              'No verse available at this moment! error:- ${e.message}');
    }
  }
}
