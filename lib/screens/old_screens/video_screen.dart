import 'dart:convert';
import 'dart:math';

import 'package:fitness_app/components/colors.dart';
import 'package:fitness_app/components/text_style.dart';
import 'package:fitness_app/my_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../components/decoration.dart';
import '../../components/icons.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  static String id = '/video_screen';

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoScreenController videoController = Get.put(VideoScreenController());
  List videoInfo = [];

  bool playVideo = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = 0;
  VideoPlayerController? _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = jsonDecode(value);
      });
    });
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: playVideo == false
            ? vs1stContainerDecoration
            : vs2ndContainerDecoration,
        child: Column(
          children: [
            playVideo == false
                ? Container(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 30.0, right: 30.0),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
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
                        const SizedBox(height: 32.0),
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
                        const SizedBox(height: 32.0),
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
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(
                            top: 50, left: 24, right: 24, bottom: 12),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (playVideo == true) {
                                    setState(() {
                                      playVideo = false;
                                    });
                                  }
                                },
                                icon: backArrowIconIOS(cSecondPageTopIcon)),
                            Expanded(child: Container()),
                            infoIcon(cSecondPageTopIcon)
                          ],
                        ),
                      ),
                      _playVideo(context),
                      Slider(
                        value: max(0, min(_progress * 100, 100)),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: _position?.toString().split('.')[0],
                        onChanged: (value) {
                          setState(() {
                            _progress = value * 0.01;
                          });
                        },
                        onChangeStart: (value) {
                          _controller?.pause();
                        },
                        onChangeEnd: (value) {
                          final duration = _controller?.value.duration;
                          if (duration != null) {
                            var newValue = max(0, min(value, 99)) * 0.01;
                            var millis =
                                (duration.inMilliseconds * newValue).toInt();
                            _controller?.seekTo(Duration(microseconds: millis));
                            _controller?.play();
                            print('$value');
                            print(_progress);
                          }
                        },
                      ),
                      _controlView(context),
                    ],
                  ),

            ///--------------------------------
            Expanded(
              child: Container(
                decoration: vs4thDecoration,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Row(
                        children: [
                          Text(
                            'Circuit 1 : Legs Toning',
                            style: kSubtitleTextStyle.copyWith(
                                color: cCircuits, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              loopIcon(cLoop),
                              const SizedBox(width: 10.0),
                              Text(
                                '3 sets',
                                style: kBodyTextStyle.copyWith(color: cSets),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: videoController.videoInfo.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              _onTapVideo(index);

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
                                              videoController.videoInfo[index]['img'],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            videoController.videoInfo[index]['title'],
                                            style: const TextStyle(
                                                fontSize: 18.0, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 16.0),
                                          Text(
                                            videoController.videoInfo[index]['time'],
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertTwo(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return '$value';
    }
  }

  Widget _controlView(BuildContext context) {
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo((remained % 60));
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: cGradientSecond.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () async {
                final index = _isPlayingIndex - 1;
                if (index >= videoController.videoInfo.length) {
                  _onTapVideo(index);
                } else {
                  Get.snackbar('Video', 'No more videos',
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 30,
                        color: Colors.white,
                      ),
                      backgroundColor: cGradientSecond,
                      colorText: Colors.white);
                }
              },
              child: TextButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  if (index <= videoController.videoInfo.length - 1) {
                    _onTapVideo(index);
                  } else {
                    Get.snackbar('Video', 'No videos');
                  }
                },
                child: backwardFillIcon(Colors.white),
              )),
          TextButton(
            onPressed: () async {
              if (_isPlaying) {
                setState(() {
                  _isPlaying = false;
                });
                _controller?.pause();
              } else {
                setState(() {
                  _isPlaying = true;
                });
                _controller?.play();
              }
            },
            child: Icon(
              _isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 30.0,
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex + 1;
              if (index <= videoController.videoInfo.length - 1) {
                _onTapVideo(index);
              } else {
                Get.snackbar('Video', 'No videos ahead !',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: cGradientSecond,
                    colorText: Colors.white);
              }
            },
            child: fastForwardIcon(Colors.white),
          ),
          Text('$mins:$secs', style: kSmallTextStyle),
        ],
      ),
    );
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

  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;

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
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration!.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _onTapVideo(int index) {
    final controller = VideoPlayerController.network(
        videoController.videoInfo[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller.initialize().then((_) {
      old?.dispose();
      _isPlayingIndex = index;
      controller.addListener(_onControllerUpdate);
      controller.play();
      setState(() {});
    });
  }
}
