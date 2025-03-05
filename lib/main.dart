import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/repository/locations_repository.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_locations_repository.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_ride_preferences_repository.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_rides_repository.dart';
import 'package:flutter_workspace_term2/service/rides_service.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'service/ride_prefs_service.dart';
import 'theme/theme.dart';

void main() {
  // 1 - Initialize the services
  // RidePref Service
  RidePrefService.initialize(MockRidePreferencesRepository());
  // Ride Service
  RidesService.initialize(MockRidesRepository());

  final LocationsRepository repository = MockLocationsRepository();

  // 2- Run the UI
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final LocationsRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen(repository: repository)),
    );
  }
}
