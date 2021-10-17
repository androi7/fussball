import 'dart:convert';

// Packages
import 'package:flutter/services.dart';

// Modelle
import '../models/models.dart';

/// Diese Klasse ahmt einen Server nach, der die Informationen
/// von einer lokalen JSON Datei (assets/sample_data/sample_teams.json)
/// abruft.
class MockApiService {
  Future<List<Team>> erhalteTeams() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final jsonString = await _ladeDaten('assets/sample_data/sample_teams.json');
    final List<dynamic> json = jsonDecode(jsonString);

    if (json.isNotEmpty) {
      final teams = <Team>[];
      for (var team in json) {
        teams.add(Team.fromJson(team));
      }
      return sortieren(teams: teams, nachName: true);
    } else {
      return [];
    }
  }

  Future<String> _ladeDaten(String path) async {
    return rootBundle.loadString(path);
  }

  static List<Team> sortieren({
    List<Team> teams = const [],
    bool nachName = true,
  }) {
    // für das Sortieren einer Liste benötigt es mindestens zwei Einheiten
    if (teams.length > 1) {
      if (nachName) {
        teams.sort((a, b) => a.name.compareTo(b.name));
      } else {
        teams.sort((a, b) {
          final vorherigerWert = a.value ?? 0;
          final naechsterWert = b.value ?? 0;
          return vorherigerWert.compareTo(naechsterWert);
        });
      }
    }
    return teams;
  }
}
