import 'package:flutter/material.dart';
import 'package:test/views/dashboard.dart';
import 'package:test/views/match.dart';
import 'package:test/views/setting.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/index':
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case '/match':
        return MaterialPageRoute(builder: (_) => MatchdScreen());
      case '/setting':
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      default:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
    }
  }
}
