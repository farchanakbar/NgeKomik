import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';

import '../controllers/detail_chapter_controller.dart';

class DetailChapterView extends GetView<DetailChapterController> {
  const DetailChapterView({super.key});
  @override
  Widget build(BuildContext context) {
    dynamic endpoint = Get.arguments;
    return Scaffold(
      body: FutureBuilder(
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
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: warnaSatu),
                    child: Center(child: Text('${snapshot.data?.title}')),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: snapshot.data?.chapters.length,
                    itemBuilder: (context, index) {
                      return Image.network('${snapshot.data?.chapters[index]}');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
