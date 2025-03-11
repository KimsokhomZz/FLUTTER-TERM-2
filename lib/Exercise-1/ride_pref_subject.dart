import 'package:flutter_workspace_term2/Exercise-1/model/ride_pref.dart';
import 'package:flutter_workspace_term2/Exercise-1/model/locations.dart';
import 'package:flutter_workspace_term2/Exercise-1/ride_pref_listener.dart';

//Subject
class RidePreferencesSubject {
  RidePref _currentRidePreference = RidePref(
    departure: Location(name: "PhnomPenh", country: Country.cambodia),
    departureDate: DateTime(2025, 4, 12), // DateTime(year, month, day)
    arrival: Location(name: "SiemReap", country: Country.cambodia),
    requestedSeats: 2,
  );

  final List<RidePreferencesListener> _listeners = [];

  void addListener(RidePreferencesListener listener) {
    _listeners.add(listener);
  }

  void removeListener(RidePreferencesListener listener) {
    _listeners.remove(listener);
  }

  void setRidePreference(RidePref newPreference) {
    // 1- Pass new Preference to current Preference
    _currentRidePreference = newPreference;
    // 2- Notify all listener
    _notifyListener();
  }

  void _notifyListener() {
    for (var listener in _listeners) {
      listener.onPreferenceSelected(_currentRidePreference);
    }
  }
}
