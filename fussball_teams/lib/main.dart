import 'package:flutter/material.dart';

import 'app_config.dart';
import 'main_common.dart';

void main() {
  const configuredApp = AppConfig(flavor: Flavor.dev, child: MyApp());
  mainCommon();
  runApp(configuredApp);
}
