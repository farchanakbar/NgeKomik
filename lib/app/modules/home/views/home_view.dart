import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/modules/home/views/populer_view.dart';
import 'package:komik_indonesia/app/modules/home/views/update_terbaru_view.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

import '../../../data/constans/color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void openBottomSheet() {
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

  void openGenreBottomSheet() {
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
    return Scaffold(
      drawer: Drawer(
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
                Navigator.pop(context);
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
                Get.toNamed(Routes.TYPE_KOMIK, arguments: {
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
                Get.toNamed(Routes.TYPE_KOMIK, arguments: {
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
                Get.toNamed(Routes.TYPE_KOMIK, arguments: {
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.telegram),
              title: const Text('Telegram'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: warnaSatu,
        title: const Text('Komik Indonesia'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              openBottomSheet();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Judul(title: 'Komik Populer'),
              PopulerTerbaru(),
              SizedBox(
                height: 10,
              ),
              Judul(title: 'Update Terbaru'),
              UpdateTerbaru()
            ],
          ),
        ),
      ),
    );
  }
}

class Judul extends StatelessWidget {
  const Judul({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: warnaSatu,
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      height: 40,
      width: Get.width,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
