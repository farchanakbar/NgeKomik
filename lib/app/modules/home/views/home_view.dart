import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komik_indonesia/app/modules/home/views/populer_view.dart';
import 'package:komik_indonesia/app/modules/home/views/update_terbaru_view.dart';
import 'package:komik_indonesia/widgets/Drawer.dart';

import '../../../data/constans/color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: FutureBuilder(
        future: controller.getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Padding(
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
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      title: 'Komik Indonesia',
      hasDrawer: true,
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
