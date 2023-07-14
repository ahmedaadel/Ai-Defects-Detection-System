import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image/image.dart' as img;

String base_url = 'http://192.168.53.122:5554';

Future<String> ImageClassification(File? image) async {
  var url = '$base_url/checkImg';

  final request = http.MultipartRequest('POST', Uri.parse(url));
  final headers = {"Content-Type": "multipart/form-data"};

  final file = await http.MultipartFile.fromPath('image', image!.path);
  request.files.add(file);
  request.headers.addAll(headers);

  var streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    return jsonResponse['classification'];
  } else {
    throw Exception('Failed to check the image ${response.statusCode}');
  }
}

Future<List<String>?> VideoClassification(List<img.Image>? frames, List<String>? detections) async {
  List<String> Classifications =[] ;
  final String apiUrl = '$base_url/checkImg';
  final headers = {"Content-Type": "multipart/form-data"};

  for (int i = 0; i < frames!.length; i++) {
    if (detections![i] != 'No detection') {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      var tempFile = await _saveImageToFile(frames[i]);
      final file = await http.MultipartFile.fromPath('image', tempFile.path);
      request.files.add(file);
      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      tempFile.delete();

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        Classifications.add(jsonResponse['classification']);
      } else {
        throw Exception('Failed to check the image ${response.statusCode}');
      }
}
  }
  return Classifications ;
}


Future<File> _saveImageToFile(img.Image image) async {
  final tempDir = await Directory.systemTemp.createTemp();
  final tempPath = '${tempDir.path}/temp_frame.jpg';

  // Save the image as a file
  File tempFile = File(tempPath);
  tempFile.writeAsBytesSync(img.encodeJpg(image));

  return tempFile;
}