import 'package:flutter/material.dart';

import 'main_common.dart';

class AppConfig extends InheritedWidget {
  // ignore: use_key_in_widget_constructors
  const AppConfig({required this.flavor, required Widget child})
      : super(child: child);

  final Flavor flavor;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
