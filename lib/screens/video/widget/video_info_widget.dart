import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/colors.dart';
import '../../../components/decoration.dart';
import '../../../components/icons.dart';
import '../../../components/text_style.dart';

class VideoInfoWidget extends StatelessWidget {
  const VideoInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 24.0, left: 24.0, right: 24.0),
      width: MediaQuery.of(context).size.width,
      height: 350,
      decoration: vs1stContainerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: backArrowIcon(Colors.white)),
              Expanded(child: Container()),
            ],
          ),
          Text(
            'Legs Toning',
            style: kTitleTextStyle.copyWith(
                color: cHomePageContainerTextSmall),
          ),
          const SizedBox(height: 8),
          Text(
            'and Glutes Workout',
            style: kTitleTextStyle.copyWith(
                color: cHomePageContainerTextSmall),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              Container(
                width: 90.0,
                height: 30.0,
                decoration: vs3rdDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    timerIcon(Colors.white),
                    const SizedBox(width: 5.0),
                    const Text(
                      '60 min',
                      style: kBodyTextStyle,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Container(
                width: 230,
                height: 30,
                decoration: vs3rdDecoration,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    handyManIcon(Colors.white),
                    const SizedBox(width: 5.0),
                    const Text(
                      'Resistance band,kettlebell',
                      style: kBodyTextStyle,
                    ),
                  ],
                ),

              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
            child: Row(
              children: [
                Text(
                  'Circuit 1 : Legs Toning',
                  style: kSubtitleTextStyle.copyWith(
                     fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    loopIcon(Colors.white),
                    const SizedBox(width: 10.0),
                    const Text(
                      '3 sets',
                      style: kBodyTextStyle,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
