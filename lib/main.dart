import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_locations_repository.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_ride_preferences_repository.dart';
import 'package:flutter_workspace_term2/repository/mock/mock_rides_repository.dart';
import 'package:flutter_workspace_term2/service/locations_service.dart';
import 'package:flutter_workspace_term2/service/rides_service.dart';
import 'screens/ride_pref/ride_pref_screen.dart';
import 'service/ride_prefs_service.dart';
import 'theme/theme.dart';

void main() {
  // 1 - Initialize mock reposite to the service
  LocationsService.initialize(MockLocationsRepository());
  RidePrefService.initialize(MockRidePreferencesRepository());
  RidesService.initialize(MockRidesRepository());

  // 3- Run the UI
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(
          body:
              RidePrefScreen(repository: LocationsService.instance.repository)),
    );
  }
}
