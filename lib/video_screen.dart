import 'dart:convert';

import 'package:fitness_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  static String id = 'video_screen';

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List videoInfo = [];
  bool playVideo = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
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
    super.initState();
    _initData();
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
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cGradientFirst.withOpacity(0.9),
                    cGradientSecond.withOpacity(0.9),
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : const BoxDecoration(color: cGradientSecond),
        child: Column(
          children: [
            playVideo == false
                ? Container(
                    padding: const EdgeInsets.only(
                        top: 70.0, left: 30.0, right: 30.0),
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
                              icon: const Icon(Icons.arrow_back_ios,
                                  size: 20.0, color: cSecondPageTopIcon),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.info_outline,
                              size: 20.0,
                              color: cSecondPageTopIcon,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32.0),
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
                        const SizedBox(height: 32.0),
                        Row(
                          children: [
                            Container(
                              width: 90.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    '60 min',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Container(
                              width: 230,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.25),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Resistance band,kettlebell',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(
                              top: 50, left: 24, right: 24),
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
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 20.0,
                                  color: cSecondPageTopIcon,
                                ),
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.info_outline,
                                color: cSecondPageTopIcon,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        _playVideo(context),
                        _controlView(context),
                      ],
                    ),
                  ),

            ///--------------------------------
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(80.0),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Row(
                        children: [
                          const Text(
                            'Circuit 1 : Legs Toning',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: cCircuits),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: const [
                              Icon(
                                Icons.loop,
                                size: 30.0,
                                color: cLoop,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                '3 sets',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: cSets,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: videoInfo.length,
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              _onTapVideo(index);
                              debugPrint(index.toString());
                              setState(() {
                                if (playVideo == false) {
                                  playVideo = true;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 20.0),
                              height: 120,
                              width: 200,
                              //color: Colors.red.withOpacity(0.5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              videoInfo[index]['img'],
                                            ),
                                          ),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     blurRadius: 30,
                                          //     offset: Offset(2, 3),
                                          //     color: Colors.grey.withOpacity(0.5)
                                          //   )
                                          // ]
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            videoInfo[index]['title'],
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
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
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFeaeefc),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
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

  Widget _controlView(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: cGradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              final index = _isPlayingIndex - 1;
              if (index >= videoInfo.length) {
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
            child: const Icon(
              Icons.fast_rewind,
              size: 30.0,
              color: Colors.white,
            ),
          ),
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
              if (index <= videoInfo.length - 1) {
                _onTapVideo(index);
              } else {
                Get.snackbar('Video', 'No videos ahead !',
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
            child: const Icon(
              Icons.fast_forward,
              size: 30.0,
              color: Colors.white,
            ),
          ),
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
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  var _onUpdateControllerTime;

  void _onControllerUpdate() async {
    if (_disposed) {
      return null;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;

    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
    }
    if (controller!.value.isInitialized) {
      debugPrint('controller not initialized');
    }
    final playing = controller.value.isPlaying;
    _isPlaying = playing;
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
