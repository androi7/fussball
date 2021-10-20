import 'package:flutter/material.dart';
import 'package:fussball_teams/app_config.dart';
import 'package:fussball_teams/main_common.dart';

void main() {
  const configuredApp = AppConfig(flavor: Flavor.test, child: MyApp());
  mainCommon();
  runApp(configuredApp);
}
