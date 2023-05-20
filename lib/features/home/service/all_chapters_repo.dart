import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bhagwat_gita/features/home/model/all_chapters_model.dart';
import 'package:bhagwat_gita/routes/api_routes.dart';
import 'package:http/http.dart' as http;

class AllChaptersService {
  Future<List<AllChaptersModel>> getAllChapters() async {
    try {
      String endpoints = '${ApiRoutes.baseURL}?limit=18';
      Uri url = Uri.parse(endpoints);

      http.Response response =
          await http.get(url, headers: ApiRoutes.apiHeaders);
      if (response.statusCode == 200) {
        List<AllChaptersModel> data =
            allChaptersModelFromJson(utf8.decode(response.bodyBytes));
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
