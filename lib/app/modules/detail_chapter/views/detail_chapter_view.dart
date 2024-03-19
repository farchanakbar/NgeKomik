import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_chapter_controller.dart';

class DetailChapterView extends GetView<DetailChapterController> {
  const DetailChapterView({super.key});
  @override
  Widget build(BuildContext context) {
    final endpoint = Get.arguments['endpoint'];
    final title = Get.arguments['title'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
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
