import 'dart:developer';
import 'dart:io';

import 'package:bhagwat_gita/features/text_to_speech/controller/text_to_speech_controller.dart';
import 'package:bhagwat_gita/features/verses/controller/verse_from_chapter_state.dart';
import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
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
        getAllCommentriesAndAuthers(data: data);
        state = state.copyWith(verseLoading: false, chapterVerseList: data, errorMessage: "");
      } else {
        state = state.copyWith(errorMessage: 'No verse available at this moment');
      }
    } on SocketException catch (e) {
      state = state.copyWith(errorMessage: 'No verse available at this moment! error:- ${e.message}');
    }
  }

  void getAllCommentriesAndAuthers({required List<VerseFromChapterModel> data}) {
    List<Commentary> listOfAllCommentriesInThisChapter = [];
    List<String> listOfAllAuthers = [];
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].commentaries.length; j++) {
        listOfAllCommentriesInThisChapter.add(data[i].commentaries[j]);
      }
    }

    for (int i = 0; i < listOfAllCommentriesInThisChapter.length; i++) {
      listOfAllAuthers.add(listOfAllCommentriesInThisChapter[i].authorName.name);
    }

    log(listOfAllCommentriesInThisChapter.length.toString());

    state = state.copyWith(
        listOfAllCommentriesInAChapter: listOfAllCommentriesInThisChapter,
        listOfAuthersOfCommentries: listOfAllAuthers);
  }

  void selecteAuthor(String value) {
    state = state.copyWith(selectedAuthor: value);
  }

  void updateVerseNumber(String index){
    state = state.copyWith(selectedVerseNumber: index);
  }

  List<Commentary> filterCommentries({required List<Commentary> listOfCommentories, required String filterValue}) {
    List<Commentary> filteredCommentaries = [];
    for (Commentary commentary in listOfCommentories) {
      if (commentary.authorName.name.contains(filterValue)) {
        filteredCommentaries.add(commentary);
      }
    }
    state = state.copyWith(filteredChapterWiseCommentries: filteredCommentaries);
    return filteredCommentaries;
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
