import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';
import 'package:http/http.dart' as http;

class AllChaptersService {
  Future<List<AllChaptersModel>> getAllChapters() async {
    try {
      String endpoints =
          'https://bhagavad-gita3.p.rapidapi.com/v2/chapters/?limit=18';
      Uri url = Uri.parse(endpoints);
      Map<String, String> headers = {
        "X-RapidAPI-Key": "e7eff69b2amsh2e26d250794a32dp1a580djsnf7ebf55b9071",
        "X-RapidAPI-Host": "bhagavad-gita3.p.rapidapi.com"
      };

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<AllChaptersModel> data = allChaptersModelFromJson(utf8.decode(response.bodyBytes));
        return data;
      } else {
        return [];
      }
    } on SocketException catch (e) {
      log(e.message);
      return [];
    }
  }
}
