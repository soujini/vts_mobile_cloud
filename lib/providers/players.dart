import 'dart:convert';

import 'package:flutter/services.dart';

class Players {
  String keyword;
  int id;
  String name;
  String country;

  Players({
    this.keyword,
    this.id,
    this.name,
    this.country
  });

  factory Players.fromJson(Map<String, dynamic> parsedJson) {
    return Players(
        keyword: parsedJson['keyword'] as String,
        id: parsedJson['id'],
        name: parsedJson['name'] as String,
        country: parsedJson['country'] as String
    );
  }
}

class PlayersViewModel {
  static List<Players> players;

  static Future loadPlayers() async {
    try {
      players = new List<Players>();
      String jsonString = await rootBundle.loadString('assets/players.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['players'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        print("aaaaa "+categoryJson[i].name);
        players.add(new Players.fromJson(categoryJson[i]));
      }
//      for (int i = 0; i < categoryJson.length; i++) {
//        players.add(new Players(
//            keyword: categoryJson[i]["keyword"],
//          id: categoryJson[i]["id"],
//          autocompleteterm: categoryJson[i]["autocompleteterm"],
//          country: categoryJson[i]["country"],
//        ));

    } catch (e) {
      print(e);
    }
  }
}
