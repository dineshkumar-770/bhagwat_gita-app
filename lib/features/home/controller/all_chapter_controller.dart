// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:bhagwat_gita/constants/constant_strings.dart';
import 'package:bhagwat_gita/features/home/controller/all_chapters_state.dart';
import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';
import 'package:bhagwat_gita/features/home/service/all_chapters_repo.dart';
import 'package:bhagwat_gita/utils/shared_prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final allChaptersProvider = StateNotifierProvider<AllChaptersNotifier, AllChaptersState>((ref) {
  return AllChaptersNotifier(
    allChaptersService: AllChaptersService(),
  );
});

class AllChaptersNotifier extends StateNotifier<AllChaptersState> {
  AllChaptersNotifier({
    required this.allChaptersService,
  }) : super(AllChaptersState.init()) {
    initThemeColor();
    getAppVersion();
    fetchAllChapters();
  }

  AllChaptersService allChaptersService;

  Future fetchAllChapters() async {
    try {
      state = state.copyWith(allChaptersLoading: true, allChapterErrorMsg: "");
      List<AllChaptersModel> response = await allChaptersService.getAllChapters();
      if (response.isNotEmpty) {
        state = state.copyWith(listOfAllChapters: response, allChapterErrorMsg: "", allChaptersLoading: false);
      } else {
        state = state.copyWith(listOfAllChapters: [], allChaptersLoading: false, allChapterErrorMsg: "No Chapters found!");
      }
    } on SocketException catch (e) {
      state = state.copyWith(
          allChapterErrorMsg: 'No Chapters found. Error: ${e.message}', allChaptersLoading: false, listOfAllChapters: []);
    }
  }

  void initThemeColor() {
    final theme = Prefs.getString(ConstantStrings.color);
    state = state.copyWith(selectedColorTheme: theme.isEmpty ? "Default" : theme);
  }

  void selectThemeColorName(String value) {
    state = state.copyWith(selectedColorTheme: value.toString());
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    state = state.copyWith(packageInfo: packageInfo);
  }

  void saveThemeData(String theme) async {
    switch (theme) {
      case ConstantStrings.softGreyBakcground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.softGreyBakcground);
        break;
      case ConstantStrings.sepiaBackground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.sepiaBackground);
        break;
      case ConstantStrings.defaultBakcground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.defaultBakcground);
        break;
      case ConstantStrings.darkModeBlackBakcground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.darkModeBlackBakcground);
        break;
      case ConstantStrings.creamyTintYellowBakcground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.creamyTintYellowBakcground);
        break;
      case ConstantStrings.brightWhiteBakcground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.brightWhiteBakcground);
        break;
      case ConstantStrings.blueGreyBackground:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.blueGreyBackground);
        break;
      default:
        await Prefs.setString(ConstantStrings.color, ConstantStrings.defaultBakcground);
        ConstantStrings.defaultBakcground;
    }
  }
}
