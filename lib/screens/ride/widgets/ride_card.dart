import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';
import 'package:flutter_workspace_term2/utils/date_time_util.dart';

import '../../../model/ride/locations.dart';

class RideCard extends StatelessWidget {
  final Location departure;
  final Location arrival;
  final DateTime departureDate;
  final int requestedSeats;
  const RideCard({
    super.key,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.requestedSeats,
  });

  //! Computer for render
  String get departureLabel => departure.toString(); //* Departure
  String get arrivalLabel => arrival.toString(); //* Arrival
  String get dateLabel =>
      DateTimeUtils.formatDateTime(departureDate); //* Departure Date
  String get numOfSeats => requestedSeats.toString(); //* Number of Seats

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(top: BlaSpacings.m),
      color: BlaColors.neutralLighter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),
      child: ListTile(
        title: Column(
          children: [
            Text(
              "Departure: $departureLabel",
              style: BlaTextStyles.body.copyWith(
                color: BlaColors.neutralDark,
              ),
            ),
            Text(
              "Arrival: $arrivalLabel",
              style: BlaTextStyles.body.copyWith(
                color: BlaColors.neutralDark,
              ),
            ),
            Text(
              "Departure Date: $dateLabel",
              style: BlaTextStyles.body.copyWith(
                color: BlaColors.neutralDark,
              ),
            ),
            Text(
              "Seats: $numOfSeats",
              style: BlaTextStyles.body.copyWith(
                color: BlaColors.neutralDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
