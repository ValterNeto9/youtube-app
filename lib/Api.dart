import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';

const API_CREDENTIAL_KEY = 'AIzaSyAOjJjpU2eKrLisSrlfnbLrwq9FaUpug48';
const KEY_CHANNEL = 'UCVHFbqXqoYvEWM1Ddxl0QDg';
const URL_BASE = 'https://www.googleapis.com/youtube/v3';

class Api {
  Future<List<Video>> pesquisar(String query) async {
    String request = "$URL_BASE/search?"
        "&part=snippet"
        "&type=video"
        "&order=date"
        "&maxResults=20"
        "&key=$API_CREDENTIAL_KEY"
        "&channelId=$KEY_CHANNEL"
        "&q=$query";

    http.Response response = await http.get(request);

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"]
                            .map<Video>((map) => Video.fromJson(map))
                            .toList();

      return videos;
    }
  }
}
