import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/data/constans/color.dart';
import 'package:komik_indonesia/app/modules/home/controllers/home_controller.dart';
import 'package:komik_indonesia/app/routes/app_pages.dart';

class UpdateTerbaru extends GetView<HomeController> {
  const UpdateTerbaru({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: controller.updateKomik.length,
          itemBuilder: (context, index) {
            final data = controller.updateKomik[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(Routes.DETAIL_KOMIK, arguments: {
                  'title': data.title as String,
                  'endpoint': data.endpoint as String
                });
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(width: 1, color: Colors.white)),
                color: warnaSatu,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.45,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${data.thumbnail}',
                                fit: BoxFit.fill,
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
                                  child: Text('${data.type}'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            for (var i in data.chapters.toList())
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_CHAPTER,
                                      arguments: {
                                        'title': i.title as String,
                                        'endpoint': i.endpoint as String
                                      });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('${i.title}'),
                                      Text('${i.updatedAt}')
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
