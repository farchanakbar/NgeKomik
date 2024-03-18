import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

import '../controllers/detail_komik_controller.dart';

class DetailKomikView extends GetView<DetailKomikController> {
  const DetailKomikView({super.key});
  @override
  Widget build(BuildContext context) {
    String title = Get.arguments['title'];
    String endpoint = Get.arguments['endpoint'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getDetail(endpoint),
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
          final data = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    color: warnaSatu,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 300,
                          width: Get.width * 0.5,
                          child: Image.network(
                            '${data?.thumbnail}',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            '${data?.title}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: warnaSatu,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type : ${data?.type}'),
                          const Jarak(),
                          Text('Status : ${data?.status}'),
                          const Jarak(),
                          Text('Rating : ${data?.rating}'),
                          const Jarak(),
                          Text('Rating : ${data?.released}'),
                          const Jarak(),
                          Text('Rating : ${data?.updatedAt}'),
                          const Jarak(),
                          Text('Rating : ${data?.description}'),
                          const Jarak(),
                          const Text('Genre : '),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                for (var i in data!.genres.toList())
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        i.title.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Jarak(),
                          const Text('Chapter'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.DETAIL_CHAPTER,
                                      arguments:
                                          data.chapterList.last.endpoint);
                                },
                                child: const Text('Chapter Pertama'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.DETAIL_CHAPTER,
                                      arguments: data.chapterList[0].endpoint);
                                },
                                child: const Text('Chapter Terakhir'),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: data.related.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  height: 40,
                                  width: Get.width,
                                  child: Center(
                                    child: Text(
                                        '${data.related[index].newestChapter}'),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Jarak extends StatelessWidget {
  const Jarak({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: Get.width,
      height: 1,
      color: Colors.white,
    );
  }
}
