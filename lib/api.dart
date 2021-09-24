import 'dart:convert';

import 'package:api_fetch_flutter/album.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<Album?> getAlbum(String id) async {
    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    );
    await Future.delayed(const Duration(seconds: 1));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Can't fetch album");
    }
  }
}
