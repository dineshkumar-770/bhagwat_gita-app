// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';

class ChapterVerseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChapterVerseLoadingState extends ChapterVerseState {}

class ChapterVerseInitialState extends ChapterVerseState {}

class ChapterVerseErrorState extends ChapterVerseState {
  final String errorMessage;
  ChapterVerseErrorState({
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [errorMessage];
}

class ChapterVerseSuccessState extends ChapterVerseState {
  final List<VerseFromChapterModel> chapterVerseList;
  ChapterVerseSuccessState({
    required this.chapterVerseList,
  });

  @override
  List<Object?> get props => [chapterVerseList];
}
