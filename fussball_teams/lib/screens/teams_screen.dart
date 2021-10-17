import 'package:flutter/material.dart';
import 'package:fussball_teams/repositories/data_repository.dart';
import 'package:fussball_teams/services/api.dart';
import 'package:fussball_teams/services/api_service.dart';
import 'package:provider/provider.dart';

// Komponenten
import '../components/team_card.dart';

// Services
import '../services/mock_api_service.dart';

// Modelle
import '../models/models.dart';

class TeamsScreen extends StatefulWidget {
  static const id = '/teams-screen';
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  late Future<List<Team>> _future;
  List<Team> _teams = [];
  var _sortierenNachName = true;
  late DataRepository _dataRepository;

  // Future<List<Team>> test() async {
  //   await Future.delayed(const Duration(
  //     milliseconds: 2000,
  //   ));
  //   return <Team>[];
  // }

  @override
  void initState() {
    super.initState();
    // _future = MockApiService().erhalteTeams();
    // _future = test();
    _dataRepository = Provider.of<DataRepository>(context, listen: false);
    _future = _dataRepository.erhalteFussballTeams();
    // _future = APIService(API()).erhalteEndpoint(endpoint: Endpoint.teams);
  }

  void _toggleFilter() {
    setState(() {
      _sortierenNachName = !_sortierenNachName;
    });
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
              _dataRepository.sortieren(
                  teams: _teams, nachName: _sortierenNachName);
              // MockApiService.sortieren(
              //   teams: _teams,
              //   nachName: _sortierenNachName,
              // );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<Team>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return _buildFallbackWidget(
                    image: 'assets/images/error.jpeg',
                    text: 'Etwas ist schief gelaufen');
              }
              if (snapshot.hasData) {
                _teams = snapshot.data as List<Team>;
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
                color: Color(0xFF01C13B),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(List<Team?> teams) {
    return ListView.separated(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index] as Team;
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
