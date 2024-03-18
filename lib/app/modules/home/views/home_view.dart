import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/modules/home/views/update_terbaru_view.dart';

import '../../../data/constans/color.dart';
import '../../../data/models/populer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaSatu,
        title: const Text('Komik Indonesia'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Judul(title: 'Komik Populer'),
              FutureBuilder(
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
                          double rating =
                              double.parse(dataPopuler.rating.toString());
                          return GestureDetector(
                            onTap: () {
                              //
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
                                            child: Text('${dataPopuler.type}'),
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
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Judul(title: 'Update Terbaru'),
              const UpdateTerbaru()
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
