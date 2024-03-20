import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

import '../controllers/detail_chapter_controller.dart';

class DetailChapterView extends GetView<DetailChapterController> {
  const DetailChapterView({super.key});
  @override
  Widget build(BuildContext context) {
    final endpoint = Get.arguments['endpoint'];
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getDetailChapter(endpoint),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('Tidak ada data'),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: Get.width,
                      color: warnaSatu,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(Icons.arrow_back)),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              '${snapshot.data?.title}',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data?.chapters.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                            '${snapshot.data?.chapters[index]}');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          snapshot.data?.prevUrl == ''
                              ? const SizedBox()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Get.offNamed(Routes.DETAIL_CHAPTER,
                                        preventDuplicates: false,
                                        arguments: {
                                          'endpoint':
                                              snapshot.data?.prevUrl as String
                                        });
                                  },
                                  child: const Text('Sebelumnya'),
                                ),
                          snapshot.data?.nextUrl == ''
                              ? const SizedBox()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Get.offNamed(Routes.DETAIL_CHAPTER,
                                        preventDuplicates: false,
                                        arguments: {
                                          'endpoint':
                                              snapshot.data?.nextUrl as String
                                        });
                                  },
                                  child: const Text('Selanjutnya'),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
