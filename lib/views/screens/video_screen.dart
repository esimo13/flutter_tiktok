import 'package:flutter/material.dart';
import 'package:flutter_tiktok/constants.dart';
import 'package:flutter_tiktok/controllers/video_controller.dart';
import 'package:flutter_tiktok/views/screens/comment_screen.dart';
import 'package:flutter_tiktok/views/widgets/circle_animation.dart';
import 'package:flutter_tiktok/views/widgets/video_player_item.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.grey, Colors.white]),
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
          body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        itemCount: videoController.videoList.length,
        itemBuilder: (context, index) {
          final data = videoController.videoList[index];
          return Stack(
            children: [
              VideoPlayerItem(videoUrl: data.videoUrl),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              data.username,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.caption,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.music_note,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                Text(
                                  data.songName,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(top: size.height / 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildProfile(data.profilePhoto),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () =>
                                      videoController.likeVideo(data.id),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 40,
                                    color: data.likes
                                            .contains(authcontroller.user.uid)
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  data.likes.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                                  id: data.id,
                                                )));
                                  },
                                  child: Icon(
                                    Icons.comment,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  data.commentCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.reply,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  data.shareCount.toString(),
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                            CircleAnimation(
                                child: buildMusicAlbum(data.profilePhoto))
                          ],
                        ),
                      )
                    ],
                  ))
                ],
              )
            ],
          );
        },
      ));
    });
  }
}
