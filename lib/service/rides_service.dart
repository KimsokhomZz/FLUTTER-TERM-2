// import '../dummy_data/dummy_data.dart';
import 'package:flutter_workspace_term2/repository/rides_repository.dart';
import '../model/ride_pref/ride_pref.dart';
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
  List<Ride> getRides(
      RidePref preference, RidesFilter? filter, RideSortType? sortType) {
    // 1- Get the rides from our ride repository
    List<Ride> rides = repository.getRides(preference, filter);

    // 2- if the sortType is provided, we sort the ride
    if (sortType != null) {
      switch (sortType) {
        case RideSortType.departureDate:
          rides.sort((a, b) {
            final dateComparison = a.departureDate.compareTo(b.departureDate);
            if (dateComparison == 0) {
              // In case that the departure date are the same, sort by available seats
              return b.availableSeats.compareTo(a.availableSeats);
            }
            return dateComparison;
          });
          break;
        case RideSortType.price:
          rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;
        case RideSortType.duration:
          rides.sort(
            (a, b) => (a.arrivalDateTime.difference(a.departureDate))
                .compareTo(b.arrivalDateTime.difference(b.departureDate)),
          );
          break;
      }
    }

    // 3- Return the rides
    return rides;
  }
}

///
///   This class handles:
///   - The filter the accept pets ride
///
class RidesFilter {
  final bool acceptPets;

  const RidesFilter({required this.acceptPets});
}

///
///   This class handles:
///   - Sorting for the Ride
///
enum RideSortType {
  departureDate,
  price,
  duration,
}
