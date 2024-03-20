import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komik_indonesia/app/data/models/genre_list.dart';
import 'package:komik_indonesia/app/data/models/latest.dart';
import 'package:komik_indonesia/app/data/models/manga.dart';
import 'package:komik_indonesia/app/data/models/manhua.dart';
import 'package:komik_indonesia/app/data/models/manhwa.dart';
import 'package:komik_indonesia/app/data/models/populer.dart';

class HomeController extends GetxController {
  late TextEditingController textEditingController = TextEditingController();
  var searchResults = [].obs;
  List<Populer> komikPopuler = [];
  List<Latest> updateKomik = [];
  List<ManhwaList> komikManhwa = [];
  List<ManhuaList> komikManhua = [];
  List<MangaList> komikManga = [];
  List<GenreList> listGenre = [];

  Future<void> getPopuler() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/popular');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      komikPopuler = data.map((e) => Populer.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  Future<void> getAllData() async {
    await getPopuler();
    await getUpdate();
  }

  Future<void> getUpdate() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/updated');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      updateKomik = data.map((e) => Latest.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  void searchKomik(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://zeronewatch-api.vercel.app/komiku/search?query=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        searchResults.value = data['datas'];
        if (query == '') {
          searchResults.value = [];
        }
      } else {
        // Handle error response
        searchResults.value = [];
      }
    } catch (e) {
      // Handle exception
      searchResults.value = [];
    }
  }

  Future<void> getManhwa() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/manhwa');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      komikManhwa = data.map((e) => ManhwaList.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  Future<void> getManhua() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/manhua');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      komikManhua = data.map((e) => ManhuaList.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  Future<void> getManga() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/manga');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      komikManga = data.map((e) => MangaList.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  Future<void> getListGenres() async {
    Uri url = Uri.parse('https://zeronewatch-api.vercel.app/komiku/genres');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['datas'];
      listGenre = data.map((e) => GenreList.fromJson(e)).toList();
    } else {
      print('Error API');
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
