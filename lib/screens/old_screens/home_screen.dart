import 'package:fitness_app/components/colors.dart';
import 'package:fitness_app/components/text_style.dart';
import 'package:fitness_app/my_controllers.dart';
import 'package:fitness_app/screens/old_screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/decoration.dart';
import '../../components/icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String id = '/home_page';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
     controller.loadingData();
    super.initState();
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
                  Text('Training',
                      style: kHeadTextStyle.copyWith(color: cHomePageTitle)),
                  Expanded(child: Container()),
                  backArrowIcon(cHomePageIcons),
                  const SizedBox(width: 16.0),
                  todayCalendarIcon(cHomePageIcons),
                  const SizedBox(width: 16.0),
                  forwardArrowIcon(cHomePageIcons),
                ],
              ),
              const SizedBox(height: 28.0),
              Text('Your program',
                  style: kTitleTextStyle.copyWith(color: cHomePageSubtitle)),
              const SizedBox(height: 24.0),
              Container(
                height: 220.0,
                width: MediaQuery.of(context).size.width,
                decoration: hp1stContainerDecoration,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0, right: 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Next workout',
                          style: kBodyTextStyle.copyWith(
                              color: cHomePageContainerTextSmall)),
                      const SizedBox(height: 8),
                      Text('Legs Toning',
                          style: kTitleTextStyle.copyWith(
                              color: cHomePageContainerTextSmall)),
                      const SizedBox(height: 8),
                      Text('and Glutes Workout',
                          style: kTitleTextStyle.copyWith(
                              color: cHomePageContainerTextSmall)),
                      const SizedBox(height: 25),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              timerIcon(Colors.white),
                              const SizedBox(width: 5),
                              const Text('60 min', style: kSmallTextStyle)
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                            onPressed: () {
                              Get.to(() => const VideoScreen());
                            },
                            icon: Container(
                              decoration: playIconDecoration,
                              child: playIcon(Colors.white),
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
                height: 140.0,
                width: MediaQuery.of(context).size.width,
                decoration: hp2ndContainerDecoration,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You are doing great',
                              style: kSubtitleTextStyle.copyWith(
                                  color: cGradientFirst,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('keep it up',
                              style: kBodyTextStyle.copyWith(
                                  color: cGradientFirst)),
                          const SizedBox(height: 8),
                          Text('stick to your plan',
                              style: kBodyTextStyle.copyWith(
                                  color: cGradientFirst)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('Area of focus',
                  style: kTitleTextStyle.copyWith(color: cHomePageTitle)),
              const SizedBox(height: 8.0),
              Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: controller.listViewBuilderCard(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
