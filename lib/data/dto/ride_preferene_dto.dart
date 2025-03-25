import 'package:flutter_workspace_term2/data/dto/location_dto.dart';
import 'package:flutter_workspace_term2/model/ride/ride_pref.dart';

class RidePreferenceDto {
  static Map<String, dynamic> toJson(RidePreference model) {
    return {
      'departure': LocationDto.toJson(model.departure),
      'arrival': LocationDto.toJson(model.arrival),
      'departureDate': model.departureDate.toIso8601String(),
      'requestedSeats': model.arrival,
    };
  }

  static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: LocationDto.fromJson(json['departure']),
      arrival: LocationDto.fromJson(json['arrival']),
      departureDate: DateTime.parse(json['departureDate']),
      requestedSeats: json['requestedSeats'],
    );
  }
}
