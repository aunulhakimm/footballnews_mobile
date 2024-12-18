import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

class WatchController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Variabel untuk video
  var selectedVideoPath = ''.obs;
  var videoPlayerController = Rx<VideoPlayerController>(VideoPlayerController.network(''));
  var isVideoPlaying = false.obs;

  // Variabel untuk audio
  var isAudioPlaying = false.obs;
  var audioDuration = Duration.zero.obs;
  var audioPosition = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();

    // Listener untuk audio
    _audioPlayer.onDurationChanged.listen((d) {
      audioDuration.value = d;
    });

    _audioPlayer.onPositionChanged.listen((p) {
      audioPosition.value = p;
    });
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    videoPlayerController.value.dispose();
    super.onClose();
  }

  // Video Functions
  Future<void> pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(source: source);
    if (video != null) {
      selectedVideoPath.value = video.path;
      videoPlayerController.value = VideoPlayerController.file(File(video.path))
        ..initialize().then((_) {
          videoPlayerController.value.play();
          isVideoPlaying.value = true;
        });
    }
  }

  void playVideo() {
    if (videoPlayerController.value.value.isPlaying) {
      videoPlayerController.value.pause();
      isVideoPlaying.value = false;
    } else {
      videoPlayerController.value.play();
      isVideoPlaying.value = true;
    }
  }

  // Audio Functions
  Future<void> playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
    isAudioPlaying.value = true;
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    isAudioPlaying.value = false;
  }

  Future<void> resumeAudio() async {
    await _audioPlayer.resume();
    isAudioPlaying.value = true;
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    isAudioPlaying.value = false;
    audioPosition.value = Duration.zero;
  }

  void seekAudio(Duration newPosition) {
    _audioPlayer.seek(newPosition);
  }
}
