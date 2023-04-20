// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bhagwat_gita/features/home/service/all_chapters_repo.dart';
import 'package:equatable/equatable.dart';

import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allChaptersProvider =
    StateNotifierProvider<AllChaptersNotifier, AllChapter>((ref) {
  return AllChaptersNotifier(allChaptersService: AllChaptersService());
});

class AllChaptersNotifier extends StateNotifier<AllChapter> {
  AllChaptersNotifier({required this.allChaptersService})
      : super(AllChaptersInitialState()) {
    fetchAllChapters();
  }

  AllChaptersService allChaptersService;

  Future fetchAllChapters() async {
    try {
      state = AllChaptersLoadingState();
      List<AllChaptersModel> data = await allChaptersService.getAllChapters();
      if (data.isNotEmpty) {
        state = AllChaptersSuccessState(listOfAllChapters: data);
      } else {
        state = AllChaptersErrorState(errorMessage: 'No Chapters found!');
      }
    } on SocketException catch (e) {
      state = AllChaptersErrorState(
          errorMessage: 'No Chapters found. Error: ${e.message}');
    }
  }
}

abstract class AllChapter extends Equatable {}

class AllChaptersLoadingState extends AllChapter {
  @override
  List<Object?> get props => [];
}

class AllChaptersInitialState extends AllChapter {
  @override
  List<Object?> get props => [];
}

class AllChaptersSuccessState extends AllChapter {
  final List<AllChaptersModel> listOfAllChapters;
  AllChaptersSuccessState({
    required this.listOfAllChapters,
  });
  @override
  List<Object?> get props => [];
}

class AllChaptersErrorState extends AllChapter {
  final String errorMessage;
  AllChaptersErrorState({
    required this.errorMessage,
  });
  @override
  List<Object?> get props => [];
}
