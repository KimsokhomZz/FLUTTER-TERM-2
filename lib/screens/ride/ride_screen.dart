import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/model/ride_pref/ride_pref.dart';
import 'package:flutter_workspace_term2/screens/ride/widgets/ride_card.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';

class RideScreen extends StatelessWidget {
  final RidePref initialRidePref;

  const RideScreen({super.key, required this.initialRidePref});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: BlaColors.white,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: BlaColors.neutralLight),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   elevation: 0,
      // ),
      body: Padding(
        padding: EdgeInsets.only(
            left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
              decoration: BoxDecoration(
                color: BlaColors.backgroundAccent,
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: BlaColors.neutralLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Spacer(),
                ],
              ),
            ),
            RideCard(
              departure: initialRidePref.departure,
              arrival: initialRidePref.arrival,
              departureDate: initialRidePref.departureDate,
              requestedSeats: initialRidePref.requestedSeats,
            ),
          ],
        ),
      ),
    );
  }
}
