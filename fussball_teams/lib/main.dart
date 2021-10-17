// Packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Theme
import 'football_theme.dart';

// Modelle
import 'models/sprache_provider.dart';

// Seite
import 'repositories/data_repository.dart';
import 'screens/teams_screen.dart';

// Services
import 'services/api.dart';
import 'services/api_service.dart';
import 'services/location_service.dart';

void main() {
  Intl.defaultLocale = 'de_DE';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FootballTheme.themeData();
    return MultiProvider(
      providers: [
        Provider<DataRepository>(
          create: (_) => DataRepository(
            apiService: APIService(API()),
          ),
        ),
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
