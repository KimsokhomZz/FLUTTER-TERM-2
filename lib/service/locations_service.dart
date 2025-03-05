import 'package:flutter_workspace_term2/model/ride/locations.dart';
import 'package:flutter_workspace_term2/repository/locations_repository.dart';

///
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static final LocationsService _instance = LocationsService._internal();
  static LocationsRepository? _repository;

  // Private constructor
  LocationsService._internal();

  // getter
  static LocationsService get instance {
    if (_repository == null) {
      throw Exception(
          "LocationsServiec is not initialized. Call initialize() first.");
    }
    return _instance;
  }

  // initail repo
  static void initialize(LocationsRepository repository) {
    _repository = repository;
  }

  // get location data
  List<Location> getLocations() {
    return _repository!.getLocations();
  }
}
