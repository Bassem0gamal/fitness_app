import 'package:fitness_app/components/icons.dart';
import 'package:fitness_app/screens/video/video_display_state.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../components/text_style.dart';

class VideoDisplayWidget extends StatelessWidget {
  final VideoDisplayState state;
  final VideoPlayerController controller;
  final Function(double) seekTo;
  final Function() backward;
  final Function() forward;
  final Function() toggle;

  const VideoDisplayWidget({
    super.key,
    required this.state,
    required this.controller,
    required this.seekTo,
    required this.backward,
    required this.forward,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    int videoIndex = 0;
    final index = videoIndex;

    return Column(
      children: [
        _playVideo(context),
        Slider(
          value: state.progress,
          divisions: 100,
          onChanged: seekTo,
          onChangeEnd: seekTo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: backward, child: backwardFillIcon(Colors.white)),
            TextButton(
                onPressed: toggle,
                child: Icon(
                  state.isPlaying ? Icons.pause_circle : Icons.play_circle,
                  size: 35.0,
                  color: Colors.white,
                )),
            TextButton(
                onPressed: forward, child: fastForwardIcon(Colors.white))
          ],
        ),
      ],
    );
  }

  Widget _playVideo(BuildContext context) {
    if (controller.value.isInitialized) {
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
