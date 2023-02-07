import 'package:fitness_app/home_page.dart';
import 'package:fitness_app/video_screen.dart';
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
      home: const HomePage(),
      initialRoute: VideoScreen.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        VideoScreen.id: (context) => const VideoScreen(),
      },
    );
  }
}
