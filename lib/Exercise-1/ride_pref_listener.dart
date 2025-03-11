import 'package:flutter_workspace_term2/Exercise-1/model/ride_pref.dart';

// Observer
abstract class RidePreferencesListener {
  void onPreferenceSelected(RidePref selectedPreference);
}

class ConsoleLogger extends RidePreferencesListener {
  @override
  void onPreferenceSelected(RidePref selectedPreference) {
    print("👋🏻 Ride preference changed to:");
    print("🚌 Departure: ${selectedPreference.departure}");
    print("📆 Departure Date: ${selectedPreference.departureDate}");
    print("📍 Arrival: ${selectedPreference.arrival}");
    print("👥 Requested Seats: ${selectedPreference.requestedSeats}");
    print("\n");
  }
}
