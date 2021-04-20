class GameData {
  int code;
  Game data;
  bool success;

  GameData({this.code, this.data, this.success});

  GameData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Game.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Game {
  String cursor;
  String tournamentCount;
  List<Tournaments> tournaments;
  bool isLastBatch;

  Game({this.cursor, this.tournamentCount, this.tournaments, this.isLastBatch});

  Game.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    tournamentCount = json['tournament_count'];
    if (json['tournaments'] != null) {
      tournaments = new List<Tournaments>();
      json['tournaments'].forEach((v) {
        tournaments.add(new Tournaments.fromJson(v));
      });
    }
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    data['tournament_count'] = this.tournamentCount;
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = this.isLastBatch;
    return data;
  }
}

class Tournaments {
  String name;
  String coverUrl;
  String gameName;

  Tournaments(
      {
        this.name,
        this.coverUrl,
        this.gameName,
      });

  Tournaments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coverUrl = json['cover_url'];
    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cover_url'] = this.coverUrl;
    data['game_name'] = this.gameName;
    return data;
  }
}
