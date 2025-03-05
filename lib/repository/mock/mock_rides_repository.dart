import 'package:flutter_workspace_term2/model/ride/locations.dart';
import 'package:flutter_workspace_term2/model/ride/ride.dart';
import 'package:flutter_workspace_term2/model/ride_pref/ride_pref.dart';
import 'package:flutter_workspace_term2/model/user/user.dart';
import 'package:flutter_workspace_term2/repository/rides_repository.dart';
import 'package:flutter_workspace_term2/service/rides_service.dart';

class MockRidesRepository extends RidesRepository {
  final mockRides = [
    Ride(
        departureLocation:
            Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
        departureDate: DateTime.now().copyWith(hour: 5, minute: 30),
        arrivalDateTime: DateTime.now().copyWith(hour: 7, minute: 30),
        driver: User(
          firstName: 'Kannika',
          lastName: 'NghaNg',
          email: 'kannika@example.com',
          phone: '1234567890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        acceptPets: false,
        availableSeats: 2,
        pricePerSeat: 25),
    Ride(
        departureLocation:
            Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
        departureDate: DateTime.now().copyWith(hour: 20, minute: 00),
        arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 00),
        driver: User(
          firstName: 'Chaylim',
          lastName: 'Kh',
          email: 'Chaylim@example.com',
          phone: '1234567890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        acceptPets: false,
        availableSeats: 0,
        pricePerSeat: 15),
    Ride(
        departureLocation:
            Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
        departureDate: DateTime.now().copyWith(hour: 5, minute: 00),
        arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 00),
        driver: User(
          firstName: 'Mengtech',
          lastName: 'Toch',
          email: 'mengtech@example.com',
          phone: '1234567890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        acceptPets: false,
        availableSeats: 1,
        pricePerSeat: 20),
    Ride(
        departureLocation:
            Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
        departureDate: DateTime.now().copyWith(hour: 20, minute: 00),
        arrivalDateTime: DateTime.now().copyWith(hour: 22, minute: 00),
        driver: User(
          firstName: 'Limhao',
          lastName: 'Kps',
          email: 'limhao@example.com',
          phone: '1234567890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        acceptPets: true,
        availableSeats: 2,
        pricePerSeat: 5),
    Ride(
        departureLocation:
            Location(name: "Battambang", country: Country.cambodia),
        arrivalLocation: Location(name: "SiemReap", country: Country.cambodia),
        departureDate: DateTime.now().copyWith(hour: 5, minute: 00),
        arrivalDateTime: DateTime.now().copyWith(hour: 8, minute: 00),
        driver: User(
          firstName: 'Sovanda',
          lastName: 'GDavith',
          email: 'vanda168@example.com',
          phone: '1234567890',
          profilePicture: 'path/to/profile/picture',
          verifiedProfile: true,
        ),
        acceptPets: false,
        availableSeats: 1,
        pricePerSeat: 25),
  ];

  @override
  List<Ride> getRides(RidePref preference, RidesFilter? filter) {
    // Filter ride based on departure and arrival locations of preference
    List<Ride> filteredRides = mockRides
        .where((ride) =>
            ride.departureLocation == preference.departure &&
            ride.arrivalLocation == preference.arrival)
        .toList();

    // Filter ride that accept pets
    if (filter != null) {
      filteredRides = filteredRides
          .where((ride) => ride.acceptPets == filter.acceptPets)
          .toList();
    }

    return filteredRides;
  }
}
