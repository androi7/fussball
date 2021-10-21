import 'dart:io';

// Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Komponenten
import '../components/team_card.dart';
import '../components/show_alert_dialog.dart';

// Repositories
import '../data/repositories/repository.dart';
import '../data/sqlite/sqlite_repository.dart';

// Services
import '../data/services/location_service.dart';

// Modelle
import '../data/models/models.dart';
import '../data/models/sprache_provider.dart';

// Konstanten
import '../constants.dart';

class TeamsScreen extends StatefulWidget {
  static const id = '/teams-screen';
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late Future<List<Team>> _futureTeams;
  late Future<List<dynamic>> _futureTotal;
  List<Team> _teams = [];
  var _sortierenNachName = true;
  late Repository _repository;
  late SpracheProvider _spracheProvider;
  final _sqlRepository = SqlRepository();
  late List<Team> _dataFromSql;

  // Future<List<Team>> test() async {
  //   await Future.delayed(const Duration(
  //     milliseconds: 2000,
  //   ));
  //   return <Team>[];
  // }

  @override
  void initState() {
    super.initState();
    // _future = test();
    _repository = Provider.of<Repository>(context, listen: false);
    _futureTeams = _repository.erhalteFussballTeams();

    _spracheProvider = Provider.of<SpracheProvider>(context, listen: false);
    Future _futureLocation =
        Provider.of<LocationService>(context, listen: false).erhalteLandName();
    _futureTotal = Future.wait([
      _futureTeams,
      _futureLocation,
    ]);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // String? countryName =
    //     await Provider.of<LocationService>(context, listen: false)
    //         .erhalteLandName();
    // print('LaenderName: $countryName');
    _dataFromSql = await _sqlRepository.erhalteFussballTeams();
  }

  void _toggleFilter() {
    setState(() {
      _sortierenNachName = !_sortierenNachName;
    });
  }

  Future<void> _erhalteNeueDaten() async {
    _futureTeams = _repository.erhalteFussballTeams();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Neue Daten'),
      duration: Duration(seconds: 1),
    ));
    // setState wird nur aufgerufen, um die Seite zu aktualisieren.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('all about clubs'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list_outlined,
              color: _sortierenNachName ? Colors.white : Colors.black,
            ),
            splashRadius: 20.0,
            onPressed: () {
              _toggleFilter();
              _repository.sortieren(
                  teams: _teams, nachName: _sortierenNachName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _erhalteNeueDaten,
          child: FutureBuilder<List<dynamic>>(
            future: _futureTotal,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  if (snapshot.error.runtimeType == SocketException) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) async {
                      showAlertDialog(
                        context: context,
                        title: 'Keine Internetverbindung',
                        content: 'Bitte überprüfen Sie ihre Internetverbindung',
                        defaultActionText: 'OK',
                      );
                    });
                    if (_dataFromSql.isNotEmpty) {
                      return _buildListView(_dataFromSql);
                    }
                  }
                  return _buildFallbackWidget(
                      image: 'assets/images/error.jpeg',
                      text: 'Etwas ist schief gelaufen');
                }
                if (snapshot.hasData) {
                  _teams = snapshot.data?[0] as List<Team>;
                  var _land = snapshot.data?[1] as String?;
                  _teams.forEach((team) => _sqlRepository.fuegeTeamHinzu(team));
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    _spracheProvider.setzeSprache(_land);
                  });
                  // _teams = [];

                  return _teams.isNotEmpty
                      ? _buildListView(_teams)
                      : _buildFallbackWidget(
                          image: 'assets/images/soccer-ball.png',
                          text: 'Keine Daten vorhanden');
                }

                return _buildFallbackWidget(
                    image: 'assets/images/soccer-ball.png',
                    text: 'Keine Daten vorhanden');
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: kHauptFarbe,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListView(List<Team> teams) {
    return ListView.separated(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];

        return TeamCard(
          image: team.image,
          team: team.name,
          country: team.country,
          value: team.value,
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.black,
          height: 1.0,
        );
      },
    );
  }

  Widget _buildFallbackWidget({image, text}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            width: MediaQuery.of(context).size.width * 0.6,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
