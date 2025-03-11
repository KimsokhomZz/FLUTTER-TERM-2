import 'package:flutter_workspace_term2/Exercise-1/model/locations.dart';
import 'package:flutter_workspace_term2/Exercise-1/model/ride_pref.dart';
import 'package:flutter_workspace_term2/Exercise-1/ride_pref_listener.dart';
import 'package:flutter_workspace_term2/Exercise-1/ride_pref_subject.dart';

void main() {
  // Sample ride preference
  RidePref preference1 = RidePref(
    departure: Location(name: "PhnomPenh", country: Country.cambodia),
    departureDate: DateTime(2025, 5, 18),
    arrival: Location(name: "Mondolkiri", country: Country.cambodia),
    requestedSeats: 2,
  );
  RidePref preference2 = RidePref(
    departure: Location(name: "PhnomPenh", country: Country.cambodia),
    departureDate: DateTime(2025, 4, 10),
    arrival: Location(name: "Kratie", country: Country.cambodia),
    requestedSeats: 3,
  );

  RidePreferencesSubject ridePreferencesSubject = RidePreferencesSubject();
  ConsoleLogger consoleLogger = ConsoleLogger();

  // Register observers
  ridePreferencesSubject.addListener(consoleLogger);

  // Update preference
  ridePreferencesSubject.setRidePreference(preference1);
  ridePreferencesSubject.setRidePreference(preference2);
}
