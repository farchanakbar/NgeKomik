import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komik_indonesia/app/data/models/manhwa.dart';

class TypeKomikController extends GetxController {
  var page = 1.obs;
  var selesai = false.obs;
  var isLoading = false.obs;
  late dynamic limit;
  var dataType = [].obs;
  Future<void> getDataKomik(String type) async {
    Uri url =
        Uri.parse('https://zeronewatch-api.vercel.app/komiku/$type?page=$page');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      limit = data['pagination'];
      print(limit);
      List dataKomik = data['datas'];
      dataType.value = dataKomik.map((e) => ManhwaList.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  void getDataTambahKomik(String type) async {
    if (page.value == limit || limit == null) {
      selesai.value = true;
    } else {
      isLoading.value = true;
      page++;
      Uri url = Uri.parse(
          'https://zeronewatch-api.vercel.app/komiku/$type?page=$page');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['datas'];
        final dataKomik = data.map((e) => ManhwaList.fromJson(e)).toList();
        dataType.addAll(dataKomik);
        isLoading.value = false;
      } else {
        print('Error API');
      }
    }
  }
}
