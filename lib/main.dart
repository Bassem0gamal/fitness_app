import 'package:fitness_app/screens/home/home_screen_2.dart';
import 'package:fitness_app/screens/video/video_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const VideoScreen2(),
      initialRoute: VideoScreen2.id,
      getPages: [
        // GetPage(
        //     name: HomeScreen.id,
        //     page: () => const HomeScreen(),
        //     binding: SampleBind()),
        // GetPage(
        //     name: VideoScreen.id,
        //     page: () => const VideoScreen(),
        //     binding: SampleBind()),
        GetPage(
          name: HomeScreen2.id,
          page: () => const HomeScreen2(),
        ),
        GetPage(
          name: VideoScreen2.id,
          page: () => const VideoScreen2(),
        ),
      ],
    );
  }
}
