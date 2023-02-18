import 'package:fitness_app/screens/video/video_category_model.dart';
import 'package:flutter/material.dart';

import '../../../components/decoration.dart';

class VideoItemWidget extends StatelessWidget {
  final VideoCategoryModel video;
  final Function() onTap;

  const VideoItemWidget({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage(
                        video.image,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      video.time,
                    ),
                  ],
                ),
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
                  width: 220,
                  height: 0.5,
                  color: Colors.grey,
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
