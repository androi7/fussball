import 'package:flutter/material.dart';
import 'package:fussball_teams/services/api_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Theme
import 'football_theme.dart';

// Seite
import 'repositories/data_repository.dart';
import 'screens/teams_screen.dart';
import 'services/api.dart';

void main() {
  Intl.defaultLocale = 'de_DE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FootballTheme.themeData();
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API())),
      child: MaterialApp(
        title: 'Fussball Teams',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const TeamsScreen(),
      ),
    );
  }
}
