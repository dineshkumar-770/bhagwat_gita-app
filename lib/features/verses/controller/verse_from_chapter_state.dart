// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';

class ChapterVerseState extends Equatable {
  final String errorMessage;
  final List<VerseFromChapterModel> chapterVerseList;
  final bool isSpeaking;
  final bool verseLoading;
  final int currentTTSIndex;
  final List<Commentary> listOfAllCommentriesInAChapter;
  final List<Commentary> filteredChapterWiseCommentries;
  final List<String> listOfAuthersOfCommentries;
  final String selectedAuthor;
  final String selectedVerseNumber;

  const ChapterVerseState({
    required this.errorMessage,
    required this.chapterVerseList,
    required this.isSpeaking,
    required this.verseLoading,
    required this.currentTTSIndex,
    required this.listOfAllCommentriesInAChapter,
    required this.filteredChapterWiseCommentries,
    required this.listOfAuthersOfCommentries,
    required this.selectedAuthor,
    required this.selectedVerseNumber,
  });

  factory ChapterVerseState.init() => const ChapterVerseState(
      chapterVerseList: [],
      currentTTSIndex: 0,
      errorMessage: "",
      filteredChapterWiseCommentries: [],
      selectedVerseNumber: "1",
      isSpeaking: false,
      verseLoading: false,
      listOfAllCommentriesInAChapter: [],
      listOfAuthersOfCommentries: [],
      selectedAuthor: "");

  @override
  List<Object> get props {
    return [
      errorMessage,
      chapterVerseList,
      isSpeaking,
      verseLoading,
      currentTTSIndex,
      listOfAllCommentriesInAChapter,
      filteredChapterWiseCommentries,
      listOfAuthersOfCommentries,
      selectedAuthor,
      selectedVerseNumber,
    ];
  }

  ChapterVerseState copyWith({
    String? errorMessage,
    List<VerseFromChapterModel>? chapterVerseList,
    bool? isSpeaking,
    bool? verseLoading,
    int? currentTTSIndex,
    List<Commentary>? listOfAllCommentriesInAChapter,
    List<Commentary>? filteredChapterWiseCommentries,
    List<String>? listOfAuthersOfCommentries,
    String? selectedAuthor,
    String? selectedVerseNumber,
  }) {
    return ChapterVerseState(
      errorMessage: errorMessage ?? this.errorMessage,
      chapterVerseList: chapterVerseList ?? this.chapterVerseList,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      verseLoading: verseLoading ?? this.verseLoading,
      currentTTSIndex: currentTTSIndex ?? this.currentTTSIndex,
      listOfAllCommentriesInAChapter: listOfAllCommentriesInAChapter ?? this.listOfAllCommentriesInAChapter,
      filteredChapterWiseCommentries: filteredChapterWiseCommentries ?? this.filteredChapterWiseCommentries,
      listOfAuthersOfCommentries: listOfAuthersOfCommentries ?? this.listOfAuthersOfCommentries,
      selectedAuthor: selectedAuthor ?? this.selectedAuthor,
      selectedVerseNumber: selectedVerseNumber ?? this.selectedVerseNumber,
    );
  }
}
