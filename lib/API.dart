import 'dart:convert';

import 'package:bluesstack_app/data/GameData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/GameData.dart';

class API{

  static String url = "tournaments-dot-game-tv-prod.uc.r.appspot.com";

  static Future<Game> getGameList(BuildContext context, String cursor) async {

    bool success;
    // List<Tournaments> tournamentList = [];
    Game game;
    try {
      var queryParameters = {
        'cursor': cursor,
        'limit': '10',
        'status':'all'
      };
      var uri = Uri.http(url,'/tournament/api/tournaments_list_v2',queryParameters);
      print("request body "+uri.toString());
      await http.get(uri).timeout(const Duration(seconds: 30)).then((http.Response response) async {

        var jsonValue = json.decode(response.body.toString());
        print("response "+ jsonValue.toString());
        success = jsonValue['success'];
        if (success == true) {
          print(" GameList jsonValue - " + response.body.toString());
          game = Game.fromJson(jsonValue['data']);

        }
      });
    } catch (err) {
      print(" GameList Error - " + err.toString());
      throw Exception("Error on server");
    }
    return game;
  }
}