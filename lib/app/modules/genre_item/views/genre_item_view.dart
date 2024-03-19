import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/data/models/genres.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

import '../controllers/genre_item_controller.dart';

class GenreItemView extends GetView<GenreItemController> {
  const GenreItemView({super.key});
  @override
  Widget build(BuildContext context) {
    String title = Get.arguments['title'];
    String endpoint = Get.arguments['endpoint'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Genre $title'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getDataKomik(endpoint),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 310,
                                mainAxisSpacing: 5,
                                childAspectRatio: 3 / 4),
                        shrinkWrap: true,
                        itemCount: controller.dataType.length,
                        itemBuilder: (context, index) {
                          GenreList dataGenre = controller.dataType[index];
                          double rating =
                              double.parse(dataGenre.rating.toString());
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_KOMIK, arguments: {
                                'title': dataGenre.title as String,
                                'endpoint': dataGenre.endpoint as String
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: warnaSatu,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          '${dataGenre.thumbnail}',
                                          fit: BoxFit.fill,
                                          height: 210,
                                          width: Get.width,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text('${dataGenre.type}'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${dataGenre.title}',
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          '${dataGenre.newestChapter}',
                                          style: const TextStyle(
                                              color: Colors.white54),
                                          textAlign: TextAlign.start,
                                        ),
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: rating / 2,
                                              itemCount: 5,
                                              itemSize: 20,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ],
                                        )
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
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => controller.selesai.value == true
                          ? const Center(
                              child: Text('Halaman Terakhir'),
                            )
                          : controller.isLoading.value
                              ? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.getDataTambahKomik(endpoint);
                                  },
                                  child: const Text('Tambah Komik'),
                                ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
