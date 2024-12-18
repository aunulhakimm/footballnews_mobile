import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../controllers/watch_controller.dart';

class WatchView extends GetView<WatchController> {
  const WatchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // URL audio yang akan diputar
    const audioUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 8, 39, 86), // Warna maroon
          ),
        ),
        title: Row(
          children: [
            Image.network(
              'https://images.seeklogo.com/logo-png/30/1/indonesia-national-football-logo-png_seeklogo-306122.png?v=638687102030000000',
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            const Text(
              "HOKIBOLA69",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              Get.offAllNamed('/signin');
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(() {
              if (controller.selectedVideoPath.value.isNotEmpty) {
                return Column(
                  children: [
                    ClipRect(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: controller.videoPlayerController.value.value.size.width,
                            height: controller.videoPlayerController.value.value.size.height,
                            child: VideoPlayer(controller.videoPlayerController.value),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.playVideo();
                      },
                      child: Text(controller.isVideoPlaying.value ? 'Pause Video' : 'Play Video'),
                    ),
                  ],
                );
              }
              return const Text('No video selected.');
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => controller.pickVideo(ImageSource.gallery),
                  child: const Text('Select from Gallery'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => controller.pickVideo(ImageSource.camera),
                  child: const Text('Record Video'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Audio Controls
            Obx(() {
              return Column(
                children: [
                  Slider(
                    min: 0.0,
                    max: controller.audioDuration.value.inSeconds.toDouble(),
                    value: controller.audioPosition.value.inSeconds.toDouble(),
                    onChanged: (value) {
                      controller.seekAudio(Duration(seconds: value.toInt()));
                    },
                  ),
                  Text(
                    '${_formatDuration(controller.audioPosition.value)} / ${_formatDuration(controller.audioDuration.value)}',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: controller.isAudioPlaying.value
                            ? controller.pauseAudio
                            : controller.resumeAudio,
                        child: Text(controller.isAudioPlaying.value ? 'Pause' : 'Resume'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => controller.playAudio(audioUrl),
                        child: const Text('Play'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: controller.stopAudio,
                        child: const Text('Stop'),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }
}
