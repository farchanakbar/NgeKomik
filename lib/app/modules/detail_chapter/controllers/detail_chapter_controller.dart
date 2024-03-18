import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komik_indonesia/app/data/models/detail_chapter.dart';

class DetailChapterController extends GetxController {
  Future<DetailChapter> getDetailChapter(String endpoint) async {
    Uri url = Uri.parse(
        'https://zeronewatch-api.vercel.app/komiku/chapter/$endpoint');
    var response = await http.get(url);
    var data = json.decode(response.body)['data'] as Map<String, dynamic>;
    return DetailChapter.fromJson(data);
  }
}
