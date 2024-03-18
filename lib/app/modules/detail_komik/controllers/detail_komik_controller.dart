import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komik_indonesia/app/data/models/detail.dart';

class DetailKomikController extends GetxController {
  Future<Detail> getDetail(String endpoint) async {
    Uri url =
        Uri.parse('https://zeronewatch-api.vercel.app/komiku/comic/$endpoint');
    var response = await http.get(url);
    var data = json.decode(response.body)['data'] as Map<String, dynamic>;
    return Detail.fromJson(data);
  }
}
