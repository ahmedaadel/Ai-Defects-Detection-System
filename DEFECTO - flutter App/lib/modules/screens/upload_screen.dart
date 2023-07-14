import 'dart:io';
import 'dart:typed_data';
import 'package:defecto/shared/remote/frames_BreakDown.dart';
import 'package:defecto/modules/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';
import '../../shared/remote/object_classification.dart';
import '../../shared/remote/object_detection.dart';
import '../../shared/constants/consts.dart';
import 'dart:async';
import 'package:image/image.dart' as img;

class UploadScreen extends StatefulWidget {
  static const id = "upload_screen";
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? image;
  File? video;
  var message;
  bool img0_vid1 = false;
  List<img.Image>? framesOfVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();

  Future pickImage() async {
    loadDetectorModel().then((value) async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final image_temp = File(image.path);

      setState(() {
        this.image = image_temp;
        img0_vid1 = false;
      });
    });
  }

  releaseResource() async {
    await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Upload Your Product'),
      ),
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'I\'m ready ,\n\nUpload your Image or Video',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: image != null
                          ? Image.file(image!)
                          : Image.asset("assets/images/logo.png"))),
              Expanded(
                flex: 1,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            pickImage().then((value) => print("DONE"));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 30, right: 30, top: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Image',
                            style: TextStyle(fontSize: 20),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            pickVideo().then((value) {
                              framesOfVideo = value;
                              setState(() {
                                img0_vid1 = true;
                              });
                              print("DONE");
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 30, right: 30, top: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text(
                            'Video',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
              //Check Button
              Expanded(
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        if (img0_vid1) {
                          checkFrames(framesOfVideo!).then((value) {
                            VideoClassification(framesOfVideo!, value);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResultScreen(result: 'Done detection')),
                            );
                          });
                        } else {
                          Future<dynamic> detect = detectFunction(image!);
                          dynamic result = await detect;
                          String resultString = result.toString();
                          if (resultString == "CastingProduct") {
                            message = await ImageClassification(image);
                          } else {
                            message = "Not Casting Product";
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResultScreen(result: message)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 30, right: 30, top: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'Check',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
