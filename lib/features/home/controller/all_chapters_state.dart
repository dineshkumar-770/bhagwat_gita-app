// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';

class AllChaptersState extends Equatable {
  final List<AllChaptersModel> listOfAllChapters;
  final bool allChaptersLoading;
  final String allChapterErrorMsg;
  final String selectedColorTheme;
  final PackageInfo? packageInfo;
  const AllChaptersState({
    required this.listOfAllChapters,
    required this.allChaptersLoading,
    required this.allChapterErrorMsg,
    required this.selectedColorTheme,
    this.packageInfo,
  });
  @override
  List<Object> get props {
    return [
      listOfAllChapters,
      allChaptersLoading,
      allChapterErrorMsg,
      selectedColorTheme,
      packageInfo!,
    ];
  }

  factory AllChaptersState.init() => const AllChaptersState(
      listOfAllChapters: [], allChapterErrorMsg: "", allChaptersLoading: false, selectedColorTheme: "Default");

  AllChaptersState copyWith({
    List<AllChaptersModel>? listOfAllChapters,
    bool? allChaptersLoading,
    String? allChapterErrorMsg,
    String? selectedColorTheme,
    PackageInfo? packageInfo,
  }) {
    return AllChaptersState(
      listOfAllChapters: listOfAllChapters ?? this.listOfAllChapters,
      allChaptersLoading: allChaptersLoading ?? this.allChaptersLoading,
      allChapterErrorMsg: allChapterErrorMsg ?? this.allChapterErrorMsg,
      selectedColorTheme: selectedColorTheme ?? this.selectedColorTheme,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }
}
