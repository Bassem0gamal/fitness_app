import 'package:fitness_app/components/decoration.dart';
import 'package:fitness_app/screens/video/video_controller.dart';
import 'package:fitness_app/screens/video/widget/video_display_widget.dart';
import 'package:fitness_app/screens/video/widget/video_info_widget.dart';
import 'package:fitness_app/screens/video/widget/video_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/colors.dart';
import '../../components/icons.dart';
import '../../components/text_style.dart';

class VideoScreen2 extends StatefulWidget {
  const VideoScreen2({Key? key}) : super(key: key);

  static String id = '/video_screen_2';

  @override
  State<VideoScreen2> createState() => _VideoScreen2State();
}

class _VideoScreen2State extends State<VideoScreen2> {
  VideoController videoController = VideoController();

  @override
  void initState() {
    videoController.fetchVideosData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: vs1stContainerDecoration,

              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Obx(() {
                final videoState = videoController.videoDisplay.value;
                if (videoState == null) {
                  return const VideoInfoWidget();
                } else {
                  return VideoDisplayWidget(
                    state: videoState,
                    controller: videoController.controller,
                    seekTo: (value) => videoController.seekTo(value),
                    backward: () => videoController.backward(),
                    forward: () => videoController.forward(),
                    toggle: () => videoController.toggle(),
                  );
                }
              }),
            ),
               Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.only(left: 24.0),
                    itemCount: videoController.videoList.length,
                    itemBuilder: (context, int i) {
                      return VideoItemWidget(
                        video: videoController.videoList[i],
                        onTap: () => videoController.playVideo(i),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
