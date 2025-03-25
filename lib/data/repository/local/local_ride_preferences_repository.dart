import 'dart:convert';

import 'package:flutter_workspace_term2/data/dto/ride_preferene_dto.dart';
import 'package:flutter_workspace_term2/data/repository/ride_preferences_repository.dart';
import 'package:flutter_workspace_term2/model/ride/ride_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // 1 - Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // 2 - Get the string list form the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    // 3 - Convert the string list to a list of RidePreferences – Using map()
    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    // 1 - Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // 2 - Call getPastPreferences
    final preferencesList = await getPastPreferences();
    // 3 - Add the new preference
    final updatedList = [
      preference,
      ...preferencesList.where((item) => item != preference)
    ];
    // 4 - Save the new list as a string list
    await prefs.setStringList(
      _preferencesKey,
      updatedList
          .map((pref) => jsonEncode(RidePreferenceDto.toJson(pref)))
          .toList(),
    );
  }
}
