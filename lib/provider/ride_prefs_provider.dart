import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/model/ride/ride_pref.dart';
import 'package:flutter_workspace_term2/provider/async_value.dart';
import 'package:flutter_workspace_term2/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  AsyncValue<List<RidePreference>>? pastPreferences;
  final RidePreferencesRepository _repository;
  RidesPreferencesProvider({required RidePreferencesRepository repository})
      : _repository = repository {
    // For now past preferences are fetched only 1 time
    fetchPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreferrence(RidePreference pref) async {
    if (pref == _currentPreference) {
      return; // We process only if the new preference is not equal to the current one
    }
    _currentPreference = pref;
    _addPreference(pref);
    notifyListeners();
  }

  void _addPreference(RidePreference newPreference) async {
    await _repository.addPreference(newPreference);
    fetchPastPreferences();
  }

  void fetchPastPreferences() async {
    pastPreferences = AsyncValue.loading();
    notifyListeners();
    try {
      List<RidePreference> pastPrefs = await _repository.getPastPreferences();
      pastPreferences = AsyncValue.success(pastPrefs);
    } catch (e) {
      pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }

  // History is returned from newest to oldest preference
  List<RidePreference> get preferencesHistory {
    if (pastPreferences?.data != null &&
        pastPreferences?.state == AsyncValueState.success) {
      return pastPreferences!.data!.reversed.toList();
    }
    return [];
  }
}
