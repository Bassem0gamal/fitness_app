import 'package:fitness_app/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  static String id = '/home_screen_2';

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  HomeController homeController = HomeController();

  @override
  void initState() {
    homeController.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => ListView.builder(
                  itemCount: homeController.categories.length,
                  itemBuilder: (context, int i) {
                    return Column(
                      children: [
                        Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    homeController.categories[i].image)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // TextButton(
            //     onPressed: () {},
            //     child: const Icon(
            //       Icons.arrow_circle_right,
            //       size: 100,
            //       color: Colors.blue,
            //     ))
          ],
        ),
      ),
    );
  }
}
