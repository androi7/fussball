import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart' as path;

// Modelle
import '../models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'FussballTeams.db';
  static const _databaseVersion = 1;

  static const teamTable = 'Teams';
  static const stadiumTable = 'Stadium';
  static const locationTable = 'Location';
  static const teamId = 'id';
  static const stadiumId = 'stadiumId';
  static const locationId = 'locationId';

  // Singleton
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static var lock = Lock();

  static Database? _database;

  Future _onCreate(Database db, int version) async {
    await db.execute('''
     CREATE TABLE $teamTable (
        $teamId STRING PRIMARY KEY,
        name TEXT NOT NULL,
        country TEXT NOT NULL,
        value INTEGER,
        image TEXT NOT NULL,
        european_titles INTEGER,
        stadium TEXT NOT NULL,
        location TEXT
      )
    ''');
  }

  Future<Database> _initDatabase() async {
    // oder verwende getDatabasesPath()
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentsDirectory.path, _databaseName);

    Sqflite.setDebugModeOn(true);

    return openDatabase(dbPath, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    await lock.synchronized(() async {
      _database ??= await _initDatabase();
    });

    return _database!;
  }

  List<Team> parseTeams(
    List<Map<String, dynamic>> teamList,
  ) {
    final teams = <Team>[];
    for (var teamMap in teamList) {
      // teamMap ist read-only
      Map<String, dynamic> map = Map<String, dynamic>.from(teamMap);
      map['stadium'] = json.decode(map['stadium']);
      map['location'] = json.decode(map['location']);
      Team team = Team.fromJson(map);
      teams.add(team);
    }
    return teams;
  }

  Stadium parseStadium(Map<String, dynamic> json) {
    return Stadium.fromJson(json);
  }

  LocationData parseLocation(Map<String, dynamic> json) {
    return LocationData.fromJson(json);
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.database;
    return db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Team>> findAllTeams() async {
    final db = await instance.database;
    final teamList = await db.query(teamTable);
    final teams = parseTeams(teamList);
    return teams;
  }

  Future<int> insertTeam(Team team) async {
    final teamMap = team.toJson();
    teamMap['stadium'] = jsonEncode(team.stadium.toJson());
    teamMap['location'] = jsonEncode(team.location?.toJson());
    return insert(teamTable, teamMap);
  }

  // TODO: update/delete Teams
}
