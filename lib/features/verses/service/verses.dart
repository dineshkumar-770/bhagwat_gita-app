import 'dart:convert';

import 'package:bhagwat_gita/features/verses/model/verse_from_chapter_model.dart';
import 'package:bhagwat_gita/routes/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final verseRepositaryProvider = Provider<VerseRepositary>((ref) {
  return VerseRepositary();
});

class VerseRepositary {
  Future<List<VerseFromChapterModel>> fetchVersesChapterWise({required int chapterNumber}) async {
    String endpoints = '${ApiRoutes.baseURL}$chapterNumber/verses/';
    Uri url = Uri.parse(endpoints);
    http.Response response = await http.get(url, headers: ApiRoutes.apiHeaders);
     if (response.statusCode == 200) {
      List<VerseFromChapterModel> verseList = [];
      final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
      for (var element in decodedData) {
        verseList.add(VerseFromChapterModel.fromJson(element));
      }
      return verseList;
    } else {
      return [];
    }
  }
}
