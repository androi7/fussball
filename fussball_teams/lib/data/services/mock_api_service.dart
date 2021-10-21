import 'dart:convert';

// Packages
import 'package:flutter/services.dart';

// Modelle
import '../models/models.dart';

// Repositories
import '../repositories/repository.dart';

/// Diese Klasse ahmt einen Server nach, der die Informationen
/// von einer lokalen JSON Datei (assets/sample_data/sample_teams.json)
/// abruft.
class MockApiService extends Repository {
  @override
  Future<List<Team>> erhalteFussballTeams() async {
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
}
