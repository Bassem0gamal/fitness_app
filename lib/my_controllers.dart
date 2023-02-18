import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'components/colors.dart';
import 'components/decoration.dart';
import 'components/text_style.dart';

class HomePageController extends GetxController {
  List info = [];

  loadingData() async {
    final data = await rootBundle.loadString("json/info.json");
    info = await jsonDecode(data);
  }

  Widget homePageCard(List info, int i) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, bottom: 16.0, top: 8.0),
      height: 170,
      width: (Get.width - 72) / 2,
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(info[i]['img']),
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
            info[i]['title'],
            style: kSubtitleTextStyle.copyWith(color: cHomePageDetail),
          ),
        ),
      ),
    );
  }

  Widget listViewBuilderCard() {
    HomePageController controller = Get.put(HomePageController());

    return ListView.builder(
        itemCount: controller.info.length.toDouble() ~/ 2,
        itemBuilder: (context, int i) {
          int a = 2 * i;
          int b = 2 * i + 1;
          return Row(
            children: [
              homePageCard(controller.info, a),
              homePageCard(controller.info, b)
            ],
          );
        });
  }
}

///............................

class VideoScreenController extends GetxController {
  List videoInfo = [];
  bool playVideo = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  VideoPlayerController? _controller;

  loadingVideoData() async {
    final videoData = await rootBundle.loadString("json/videoinfo.json");
    videoInfo = await jsonDecode(videoData);
    //print('$videoInfo');
  }

  Widget videoScreenListBuilder() {
    return Expanded(
      child: ListView.builder(
        itemCount: videoInfo.length,
        itemBuilder: (_, int index) {
          return GestureDetector(
            onTap: () {
              _onTapVideo(index);
              debugPrint(index.toString());

              if (playVideo == false) {
                playVideo = true;
              }
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20.0),
              height: 120,
              width: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: AssetImage(
                              videoInfo[index]['img'],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            videoInfo[index]['title'],
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            videoInfo[index]['time'],
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 80,
                        decoration: vs5Decoration,
                        child: const Center(
                          child: Text(
                            '15s Rest',
                            style: TextStyle(
                              color: Color(0xFF839fed),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 0.5,
                        color: Colors.grey,
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    update();
    controller.initialize().then((_) {
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      update();
    });
  }

  void _onControllerUpdate() async {
    if (_disposed) {
      return null;
    }
    int onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (onUpdateControllerTime > now) {
      return;
    }
    onUpdateControllerTime = now + 500;

    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
    }
    if (controller!.value.isInitialized) {
      debugPrint('controller not initialized');
    }
    var duration = _duration;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    _isPlaying = playing;
    _duration ??= _controller?.value.duration;
    if (playing) {
      if (_disposed) return;

      _progress = position!.inMilliseconds.ceilToDouble() /
          duration!.inMilliseconds.ceilToDouble();
      update();
    }
    _isPlaying = playing;
  }

  Widget _playVideo(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            'Loading...',
            style: kSubtitleTextStyle,
          ),
        ),
      );
    }
  }
}

class SampleBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => VideoScreenController());
  }
}
