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
  final List<Commentary> filteredListOfAllCommentriesInAChapter;
  final List<String> listOfAllAuthorsOfCommentries;
  final List<Commentary> filteredChapterWiseCommentries;
  final List<String> listOfAuthersOfCommentries;
  final String selectedAuthor;
  final String selectedVerseNumber;
  final String selectedAllCommentriesAuthor;

  const ChapterVerseState({
    required this.errorMessage,
    required this.chapterVerseList,
    required this.isSpeaking,
    required this.verseLoading,
    required this.currentTTSIndex,
    required this.listOfAllCommentriesInAChapter,
    required this.filteredListOfAllCommentriesInAChapter,
    required this.listOfAllAuthorsOfCommentries,
    required this.filteredChapterWiseCommentries,
    required this.listOfAuthersOfCommentries,
    required this.selectedAuthor,
    required this.selectedVerseNumber,
    required this.selectedAllCommentriesAuthor,
  });

  factory ChapterVerseState.init() => const ChapterVerseState(
      chapterVerseList: [],
      currentTTSIndex: 0,
      errorMessage: "",
      filteredChapterWiseCommentries: [],
      selectedVerseNumber: "1",
      filteredListOfAllCommentriesInAChapter: [],
      selectedAllCommentriesAuthor: "",
      isSpeaking: false,
      listOfAllAuthorsOfCommentries: [],
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
      filteredListOfAllCommentriesInAChapter,
      listOfAllAuthorsOfCommentries,
      filteredChapterWiseCommentries,
      listOfAuthersOfCommentries,
      selectedAuthor,
      selectedVerseNumber,
      selectedAllCommentriesAuthor,
    ];
  }

  ChapterVerseState copyWith({
    String? errorMessage,
    List<VerseFromChapterModel>? chapterVerseList,
    bool? isSpeaking,
    bool? verseLoading,
    int? currentTTSIndex,
    List<Commentary>? listOfAllCommentriesInAChapter,
    List<Commentary>? filteredListOfAllCommentriesInAChapter,
    List<String>? listOfAllAuthorsOfCommentries,
    List<Commentary>? filteredChapterWiseCommentries,
    List<String>? listOfAuthersOfCommentries,
    String? selectedAuthor,
    String? selectedVerseNumber,
    String? selectedAllCommentriesAuthor,
  }) {
    return ChapterVerseState(
      errorMessage: errorMessage ?? this.errorMessage,
      chapterVerseList: chapterVerseList ?? this.chapterVerseList,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      verseLoading: verseLoading ?? this.verseLoading,
      currentTTSIndex: currentTTSIndex ?? this.currentTTSIndex,
      listOfAllCommentriesInAChapter: listOfAllCommentriesInAChapter ?? this.listOfAllCommentriesInAChapter,
      filteredListOfAllCommentriesInAChapter: filteredListOfAllCommentriesInAChapter ?? this.filteredListOfAllCommentriesInAChapter,
      listOfAllAuthorsOfCommentries: listOfAllAuthorsOfCommentries ?? this.listOfAllAuthorsOfCommentries,
      filteredChapterWiseCommentries: filteredChapterWiseCommentries ?? this.filteredChapterWiseCommentries,
      listOfAuthersOfCommentries: listOfAuthersOfCommentries ?? this.listOfAuthersOfCommentries,
      selectedAuthor: selectedAuthor ?? this.selectedAuthor,
      selectedVerseNumber: selectedVerseNumber ?? this.selectedVerseNumber,
      selectedAllCommentriesAuthor: selectedAllCommentriesAuthor ?? this.selectedAllCommentriesAuthor,
    );
  }
}
