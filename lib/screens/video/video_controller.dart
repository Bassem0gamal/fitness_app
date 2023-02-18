import 'dart:convert';
import 'dart:math';

import 'package:fitness_app/screens/video/video_category_model.dart';
import 'package:fitness_app/screens/video/video_display_state.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../components/colors.dart';
import '../../components/text_style.dart';

class VideoController extends GetxController {
  final RxList<VideoCategoryModel> videoList = RxList<VideoCategoryModel>();
  final Rx<VideoDisplayState?> videoDisplay = Rx<VideoDisplayState?>(null);
  late VideoPlayerController controller;

  int currentIndex = -1;

  Future<void> fetchVideosData() async {
    final data = await rootBundle.loadString("json/videoinfo.json");
    final List jsonList = await jsonDecode(data);
    final List<VideoCategoryModel> result = [];

    for (var map in jsonList) {
      map = VideoCategoryModel(
          title: map['title'],
          time: map['time'],
          image: map['img'],
          videoUrl: map['videoUrl']);
      result.add(map);
    }
    videoList.value = result;
    print(videoList);
  }

  void seekTo(double value) {
    videoDisplay.value?.progress = value;
    update();

    final duration = controller.value.duration;
    var millis = (duration.inMilliseconds * value).toInt();
    controller.seekTo(Duration(milliseconds: millis));
  }

  void backward() {
    if (currentIndex > 0) {
      playVideo(currentIndex - 1);
    } else {
      Get.snackbar('Videos', 'No videos');
    }
  }

  void forward() {
    if (currentIndex < videoList.length - 1) {
      playVideo(currentIndex + 1);
    } else {
      Get.snackbar('Videos', 'No videos');
    }
  }

  void toggle() {
    if (videoDisplay.value!.isPlaying == false) {
      videoDisplay.value!.isPlaying = true;
      controller.play();
    } else {
      videoDisplay.value!.isPlaying = false;
      controller.pause();
    }
    update();
  }

  void playVideo(int index) async {
    final video = videoList[index];
    currentIndex = index;

    controller = VideoPlayerController.network(video.videoUrl);
    await controller.initialize();
    await controller.play();
    controller.addListener(() => onControllerUpdate() );


    videoDisplay.value =
        VideoDisplayState(isPlaying: true, progress: 0.0, remain: '');
    update();
  }

  onControllerUpdate() async {
    final position = await controller.position;
    if (position != null){
      final totalDuration = controller.value.duration;
      final progress = position.inMilliseconds / totalDuration.inMilliseconds;
      videoDisplay.value?.progress = progress;
      update();
    }
  }

// onTapVideo(int index) {
//   int isPlayingIndex = -1;
//   final controller =
//       VideoPlayerController.network(videoCategory[index].videoUrl);
//   final old = controller0;
//   controller0 = controller;
//   if (old != null) {
//     old.removeListener(onControllerUpdate);
//     old.pause();
//   }
//   update();
//   controller.initialize().then((_) {
//     old?.dispose();
//     isPlayingIndex = index;
//     controller.addListener(onControllerUpdate);
//     controller.play();
//     update();
//   });
// }

// void onControllerUpdate() async {
//   var progress = 0.0;
//   Duration? oldPosition;
//   Duration? oldDuration;
//
//   final controller = controller0;
//
//   var duration = oldDuration;
//
//   var position = await controller?.position;
//   oldPosition = position;
//
//   final playing = controller?.value.isPlaying;
//   isPlaying = playing!;
//   oldDuration ??= controller0?.value.duration;
//   if (playing) {
//     progress = position!.inMilliseconds.ceilToDouble();
//     duration!.inMilliseconds.ceilToDouble();
//   }
//   isPlaying = playing;
// }

// Widget playVideo(BuildContext context) {
//   final controller = controller0;
//   if (controller != null && controller.value.isInitialized) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: VideoPlayer(controller),
//     );
//   } else {
//     return const AspectRatio(
//       aspectRatio: 16 / 9,
//       child: Center(
//         child: Text(
//           'Loading...',
//           style: kSubtitleTextStyle,
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> playAndPause() async {
//   if (isPlaying) {
//     isPlaying = false;
//     update();
//     controller0?.pause();
//   } else {
//     isPlaying = true;
//     update();
//     controller0?.play();
//   }
// }

// Future<void> nextVideo() async {
//   final index = isPlayingIndex + 1;
//   if (index <= videoCategory.length - 1) {
//     onTapVideo(index);
//   } else {
//     Get.snackbar('Video', 'No videos ahead !',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: cGradientSecond,
//         colorText: Colors.white);
//   }
// }
//
// Future<void> pastVideo() async {
//   final index = isPlayingIndex - 1;
//   if (index >= videoCategory.length) {
//     onTapVideo(index);
//   } else {
//     Get.snackbar('Video', 'No more videos',
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: cGradientSecond,
//         colorText: Colors.white);
//   }
// }
}
