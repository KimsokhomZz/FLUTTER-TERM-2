import 'package:flutter_workspace_term2/model/ride/ride.dart';
import 'package:flutter_workspace_term2/model/ride_pref/ride_pref.dart';
import 'package:flutter_workspace_term2/service/rides_service.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePref preference, RidesFilter? filter);
}
