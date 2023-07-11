import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper({required this.url});

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    }
    return Future.error(response.statusCode);
  }
}
