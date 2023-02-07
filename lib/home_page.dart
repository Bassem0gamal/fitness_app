import 'dart:convert';

import 'package:fitness_app/colors.dart';
import 'package:fitness_app/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];

  _initData() {
    DefaultAssetBundle.of(context).loadString("json/info.json").then((value) {
      setState(() {
        info = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cHomePageBackGround,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 24.0,
            left: 24.0,
            top: 32.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Training',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: cHomePageTitle,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.arrow_back,
                    size: 24.0,
                    color: cHomePageIcons,
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(
                    Icons.calendar_today,
                    size: 24.0,
                    color: cHomePageIcons,
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(
                    Icons.arrow_forward,
                    size: 24.0,
                    color: cHomePageIcons,
                  )
                ],
              ),
              const SizedBox(height: 28.0),
              Row(
                children: [
                  const Text(
                    'Your program',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: cHomePageSubtitle,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  const Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: cHomePageDetail,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  const Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: cHomePageDetail,
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              Container(
                height: 220.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      cGradientFirst.withOpacity(0.9),
                      cGradientSecond.withOpacity(0.9),
                    ], begin: Alignment.bottomLeft, end: Alignment.topRight),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(80.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(5, 10),
                          blurRadius: 20.0,
                          color: cGradientSecond.withOpacity(0.5))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0, right: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Next workout',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: cHomePageContainerTextSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Legs Toning',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: cHomePageContainerTextSmall,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'and Glutes Workout',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: cHomePageContainerTextSmall,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.timer_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '60 min',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {
                              Get.to(() => const VideoScreen());
                            },
                            icon: Container(
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: cGradientFirst,
                                  blurRadius: 10.0,
                                  offset: Offset(4, 8),
                                )
                              ]),
                              child: const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 52,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Container(
                padding: const EdgeInsets.all(0),
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 40.0,
                          offset: const Offset(8, 10),
                          color: cGradientSecond.withOpacity(0.3))
                    ]),
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      width: 350,
                      // margin: const EdgeInsets.only(right: 180),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage('assets/logo 3.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'You are doing great',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: cGradientFirst,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'keep it up',
                            style: TextStyle(
                                fontSize: 16.0, color: cGradientFirst),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'stick to your plan',
                            style: TextStyle(
                                fontSize: 16.0, color: cGradientFirst),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Area of focus',
                style: TextStyle(
                  fontSize: 24.0,
                  color: cHomePageTitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: info.length.toDouble() ~/ 2,
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 24.0, bottom: 16.0, top: 8.0),
                            height: 170,
                            width: (MediaQuery.of(context).size.width - 72) / 2,
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(info[a]['img']),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(5, 5),
                                    color: cGradientSecond.withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(-5, -5),
                                    color: cGradientSecond.withOpacity(0.2),
                                  ),
                                ]),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[a]['title'],
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: cHomePageDetail,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 24.0, bottom: 16.0, top: 8.0),
                            height: 170,
                            width: (MediaQuery.of(context).size.width - 72) / 2,
                            padding: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(info[b]['img']),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(5, 5),
                                    color: cGradientSecond.withOpacity(0.2),
                                  ),
                                  BoxShadow(
                                    blurRadius: 10,
                                    offset: const Offset(-5, -5),
                                    color: cGradientSecond.withOpacity(0.2),
                                  ),
                                ]),
                            child: Center(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[b]['title'],
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    color: cHomePageDetail,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
