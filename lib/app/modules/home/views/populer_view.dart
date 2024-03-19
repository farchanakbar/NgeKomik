import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/modules/home/controllers/home_controller.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

import '../../../data/models/populer.dart';

class PopulerTerbaru extends GetView<HomeController> {
  const PopulerTerbaru({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getPopuler(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height: 310,
            width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: controller.komikPopuler.length,
              itemBuilder: (context, index) {
                Populer dataPopuler = controller.komikPopuler[index];
                double rating = double.parse(dataPopuler.rating.toString());
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_KOMIK, arguments: {
                      'title': dataPopuler.title as String,
                      'endpoint': dataPopuler.endpoint as String
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
                    width: Get.width * 0.45,
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
                                '${dataPopuler.thumbnail}',
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
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text('${dataPopuler.type}'),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${dataPopuler.title}',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                '${dataPopuler.newestChapter}',
                                style: const TextStyle(color: Colors.white54),
                                textAlign: TextAlign.start,
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: rating / 2,
                                    itemCount: 5,
                                    itemSize: 20,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, _) => const Icon(
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
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
