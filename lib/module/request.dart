import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:ollie_photo_social/constants.dart';
import 'package:ollie_photo_social/module/storage.dart';

Future<Map<String, dynamic>> $post(String url, Map data,
    [bool isSigned = false]) async {
  var headers = {"Content-Type": "application/json"};
  var token = await AppStorage.getToken();
  if (isSigned && token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
  Response response = await post(
    '${endpoint + url}',
    headers: headers,
    body: json.encode(data),
  );

  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> $get(String url, [bool isSigned = false]) async {
  var token = await AppStorage.getToken();
  var headers = {"Content-Type": "application/json"};
  if (isSigned && token != null && token.isNotEmpty) {
    headers['Authorization'] = 'Bearer $token';
  }
  Response response = await get(
    '${endpoint + url}',
    headers: headers,
  );

  return jsonDecode(response.body);
}

Future<int> $formUpload(
    String url, Map<String, String> fields, Map<String, List> files) async {
  var token = await AppStorage.getToken();
  var request = MultipartRequest("POST", Uri.parse(endpoint + url));
  request.headers.addAll({
    "Authorization": "Bearer $token",
    "Content-Type": "multipart/form-data"
  });
  fields.forEach((key, value) => request.fields[key] = value);
  if (files != null && files.isNotEmpty)
    for (var fileKey in files.keys)
      for (int idx = 0; idx < files[fileKey].length; idx++) {
        var filePath = File(files[fileKey][idx]).path;
        var _file = await MultipartFile.fromPath(
          '$fileKey[$idx]',
          filePath,
          filename: filePath.split('/').last,
        );
        request.files.add(_file);
      }

  StreamedResponse response = await request.send();
  return response.statusCode;
}
