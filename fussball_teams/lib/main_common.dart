// Packages
import 'package:flutter/material.dart';
import 'package:fussball_teams/app_config.dart';
import 'package:fussball_teams/repositories/repository.dart';
import 'package:fussball_teams/services/mock_api_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Theme
import 'football_theme.dart';

// Modelle
import 'models/sprache_provider.dart';

// Seite
import 'screens/teams_screen.dart';

// Services
import 'services/api.dart';
import 'services/api_service.dart';
import 'services/location_service.dart';

import 'repositories/data_repository.dart';

enum Flavor {
  dev,
  test,
}

void mainCommon() {
  Intl.defaultLocale = 'de_DE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FootballTheme.themeData();
    var config = AppConfig.of(context);
    return _buildApp(config != null ? config.flavor : Flavor.test, theme);
  }

  Widget _buildApp(Flavor flavor, ThemeData theme) {
    return MultiProvider(
      providers: [
        if (flavor == Flavor.dev)
          Provider<Repository>(
            create: (_) => DataRepository(
              apiService: APIService(API()),
            ),
          ),
        if (flavor == Flavor.test)
          Provider<Repository>(create: (_) => MockApiService()),
        Provider<LocationService>(
          create: (_) => LocationService(),
        ),
        ChangeNotifierProvider<SpracheProvider>(
          create: (_) => SpracheProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fussball Teams',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const TeamsScreen(),
      ),
    );
  }
}
