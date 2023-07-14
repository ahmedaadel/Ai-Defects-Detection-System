import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:async';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


Future<void> loadDetectorModel() async {
  String? res = await Tflite.loadModel(
      model: "assets/detection.tflite",
      labels: "assets/labels.txt",
      numThreads: 1, // defaults to 1
      isAsset:
      true, // defaults to true, set to false to load resources outside assets
      useGpuDelegate:
      false // defaults to false, set to true to use GPU delegate
  );
}

Future<String> detectFunction(File img) async {
  String res = "none";
  var recognitions = await Tflite.runModelOnImage(
      path: img.path, // required
      imageMean: 0.0, // defaults to 117.0
      imageStd: 255.0, // defaults to 1.0
      numResults: 2, // defaults to 5
      threshold: 0.9, // defaults to 0.1
      asynch: true // defaults to true
  );
  print(recognitions);
  res = recognitions![0]['label'];
  res = res.substring(2);
  print(res);
   return res ;
}


Future<String> detectFunction2(img.Image frame) async {
  String res = "none";

  // Get the temporary directory path
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  print (tempPath);
  // Create a temporary file path
  String tempFilePath = '$tempPath/temp_frame.jpg';

  // Save the image as a file
  File tempFile = File(tempFilePath);
  tempFile.writeAsBytesSync(img.encodeJpg(frame));

  var recognitions = await Tflite.runModelOnImage(
    path: tempFile.path,
    imageMean: 0.0,
    imageStd: 255.0,
    numResults: 2,
    threshold: 0.9,
    asynch: true,
  );

  res = recognitions![0]['label'];
  print(recognitions!);
  res = res.substring(2);

  // Delete the temporary file
  tempFile.delete();

  return res;
}




