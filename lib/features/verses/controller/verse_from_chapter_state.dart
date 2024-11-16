// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';

class ChapterVerseState extends Equatable {
  final String errorMessage;
  final List<VerseFromChapterModel> chapterVerseList;
  final bool isSpeaking;
  final bool verseLoading;
  final int currentTTSIndex;

  const ChapterVerseState({
    required this.errorMessage,
    required this.chapterVerseList,
    required this.isSpeaking,
    required this.verseLoading,
    required this.currentTTSIndex,
  });

  factory ChapterVerseState.init() =>
      const ChapterVerseState(chapterVerseList: [], currentTTSIndex: 0, errorMessage: "", isSpeaking: false, verseLoading: false);

  @override
  List<Object> get props => [errorMessage, chapterVerseList, isSpeaking, verseLoading, currentTTSIndex];

  ChapterVerseState copyWith({
    String? errorMessage,
    List<VerseFromChapterModel>? chapterVerseList,
    bool? isSpeaking,
    bool? verseLoading,
    int? currentTTSIndex,
  }) {
    return ChapterVerseState(
      errorMessage: errorMessage ?? this.errorMessage,
      chapterVerseList: chapterVerseList ?? this.chapterVerseList,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      verseLoading: verseLoading ?? this.verseLoading,
      currentTTSIndex: currentTTSIndex ?? this.currentTTSIndex,
    );
  }
}

// class ChapterVerseState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ChapterVerseLoadingState extends ChapterVerseState {}

// class ChapterVerseInitialState extends ChapterVerseState {}

// class ChapterVerseErrorState extends ChapterVerseState {
//   final String errorMessage;
//   ChapterVerseErrorState({
//     required this.errorMessage,
//   });
//   @override
//   List<Object?> get props => [errorMessage];
// }

// class ChapterVerseSuccessState extends ChapterVerseState {
//   final List<VerseFromChapterModel> chapterVerseList;
//   final bool isSpeaking;
//   ChapterVerseSuccessState({
//     required this.chapterVerseList,
//     required this.isSpeaking,
//   });

//   @override
//   List<Object?> get props => [chapterVerseList, isSpeaking];

//   ChapterVerseSuccessState copyWith({
//     List<VerseFromChapterModel>? chapterVerseList,
//     bool? isSpeaking,
//   }) {
//     return ChapterVerseSuccessState(
//       chapterVerseList: chapterVerseList ?? this.chapterVerseList,
//       isSpeaking: isSpeaking ?? this.isSpeaking,
//     );
//   }
// }
