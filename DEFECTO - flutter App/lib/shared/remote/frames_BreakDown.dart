import 'dart:io';
import 'package:defecto/shared/remote/object_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:async';
import 'package:image/image.dart' as img;

final ImagePicker _picker = ImagePicker();

Future<List<img.Image>> pickVideo() async {
  final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

  final videoFile = File(video!.path);
  final videoController = VideoPlayerController.file(videoFile);
  await videoController.initialize();

  Duration videoDuration = videoController.value.duration;
  Duration frameInterval = Duration(seconds: 3);
  Duration frameTime = Duration();

  List<img.Image> frames = [];

  while (frameTime < videoDuration) {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: video.path,
      imageFormat: ImageFormat.JPEG,
      timeMs: frameTime.inMilliseconds,
    );

    img.Image frame = img.decodeImage(File(thumbnailPath!).readAsBytesSync())!;
    frames.add(frame);

    frameTime += frameInterval;
  }

  print(frames);
  return frames;

}


Future<List<String>> checkFrames(List<img.Image> frames) async {
  List<String> results = [];
  for (var frame in frames) {
    String result = await detectFunction2(frame);
    print(result);
    results.add(result);
  }
  return results;
}
