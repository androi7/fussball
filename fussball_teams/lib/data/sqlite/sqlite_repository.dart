import '../models/models.dart';
import '../repositories/repository.dart';
import 'database_helper.dart';

class SqlRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<Team>> erhalteFussballTeams() {
    return dbHelper.findAllTeams();
  }

  Future<int> fuegeTeamHinzu(Team team) {
    return dbHelper.insertTeam(team);
  }
}
