import 'package:flutter_workspace_term2/repository/rides_repository.dart';

import '../model/ride_pref/ride_pref.dart';
import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

///
///   This service handles:
///   - The list of available rides
///
class RidesService {
  // Static private instance
  static RidesService? _instance;

  // Access to past preferences
  final RidesRepository repository;

  ///
  /// Private constructor
  ///
  RidesService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  //
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  // Get rides
  List<Ride> getRides(RidePref preference, RidesFilter? filter) {
    return repository.getRides(preference, filter);
  }
}

///
///   This class handles:
///   - The filter
///
class RidesFilter {
  final bool acceptPets;

  const RidesFilter({required this.acceptPets});
}
