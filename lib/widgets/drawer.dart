import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/modules/home/controllers/home_controller.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final bool hasDrawer;
  final String title;

  const MyScaffold(
      {super.key,
      required this.body,
      this.hasDrawer = false,
      required this.title});

  void openBottomSheet() {
    var controller = Get.put(HomeController());
    if (Get.isBottomSheetOpen == false) {
      controller.textEditingController.clear();
      controller.searchResults.value = [];
    }
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        width: Get.width,
        decoration: const BoxDecoration(
          color: warnaSatu,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Cari Judul Komik',
                  labelText: 'Judul Komik',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.searchKomik(value);
                },
              ),
              Obx(() => Expanded(
                    child: ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final search = controller.searchResults[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: warnaSatu,
                                    border: Border.all(
                                        width: 1, color: Colors.white)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ListTile(
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(Routes.DETAIL_KOMIK,
                                          arguments: {
                                            'title': search['title'] as String,
                                            'endpoint':
                                                search['endpoint'] as String
                                          });
                                    },
                                    leading: Image.network(search['thumbnail']),
                                    title: Text(
                                      '${search['title']}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle:
                                        Text('${search['newest_chapter']}'),
                                    trailing:
                                        Text('Rating ${search['rating']}'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void openGenreBottomSheet() {
    var controller = Get.put(HomeController());
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        width: Get.width,
        decoration: const BoxDecoration(
          color: warnaSatu,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: FutureBuilder(
          future: controller.getListGenres(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: GridView.builder(
                  itemCount: controller.listGenre.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 50,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    final dataGenre = controller.listGenre[index];
                    return SizedBox(
                      height: 50,
                      width: 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.toNamed(Routes.GENRE_ITEM, arguments: {
                            'title': dataGenre.title,
                            'endpoint': dataGenre.endpoint
                          });
                        },
                        child: Text('${dataGenre.title}'),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentTime;
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentTime == null ||
            now.difference(currentTime) > const Duration(seconds: 1)) {
          //add duration of press gap
          currentTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tekan lagi untuk keluar')));
          return Future.value(false);
        } else {
          SystemNavigator.pop();
          exit(0);
        }
      },
      child: Scaffold(
        drawer: hasDrawer
            ? Drawer(
                backgroundColor: warnaSatu,
                child: ListView(
                  children: [
                    const DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/solo.jpg"),
                            fit: BoxFit.cover,
                          ),
                          color: warnaSatu,
                        ), //BoxDecoration
                        child: SizedBox() //UserAccountDrawerHeader
                        ), //DrawerHeader
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {
                        Get.offAllNamed(Routes.HOME);
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/images/korea_selatan.png'),
                      ),
                      title: const Text('Manhwa'),
                      onTap: () {
                        Get.back();
                        Get.offAllNamed(Routes.TYPE_KOMIK, arguments: {
                          'title': 'Manhwa',
                          'endpoint': 'manhwa',
                        });
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/images/china.png'),
                      ),
                      title: const Text('Manhua'),
                      onTap: () {
                        Get.back();
                        Get.offAllNamed(Routes.TYPE_KOMIK, arguments: {
                          'title': 'Manhua',
                          'endpoint': 'manhua',
                        });
                      },
                    ),
                    ListTile(
                      leading: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/images/japan.png'),
                      ),
                      title: const Text('Manga'),
                      onTap: () {
                        Get.back();
                        Get.offAllNamed(Routes.TYPE_KOMIK, arguments: {
                          'title': 'Manga',
                          'endpoint': 'manga',
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.solidFaceSmile),
                      title: const Text('Genre'),
                      onTap: () {
                        Get.back();
                        openGenreBottomSheet();
                      },
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.circleDollarToSlot),
                      title: const Text('Donate'),
                      onTap: () {
                        launchURL('https://trakteer.id/Ngewibuu/tip');
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Informasi',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.squareInstagram),
                      title: const Text('Instagram'),
                      onTap: () {
                        launchURL('https://www.instagram.com/ngewibuu.komik');
                      },
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.telegram),
                      title: const Text('Telegram'),
                      onTap: () {
                        launchURL('https://t.me/ngewibuuaja');
                      },
                    ),
                  ],
                ),
              )
            : null,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                openBottomSheet();
              },
              icon: const Icon(Icons.search),
            )
          ],
          elevation: 3.0,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.purple,
        ),
        body: body,
      ),
    );
  }
}
