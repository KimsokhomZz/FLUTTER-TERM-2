import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/screens/ride/ride_screen.dart';
import 'package:flutter_workspace_term2/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:flutter_workspace_term2/utils/animations_util.dart';
import 'package:flutter_workspace_term2/utils/date_time_util.dart';
import 'package:flutter_workspace_term2/widgets/actions/bla_button.dart';
import 'package:flutter_workspace_term2/widgets/display/bla_divider.dart';
import 'package:flutter_workspace_term2/widgets/inputs/bla_date_picker.dart';
import 'package:flutter_workspace_term2/widgets/inputs/bla_location_picker.dart';
import 'package:flutter_workspace_term2/screens/ride_pref/widgets/ride_pref_request_seat.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  //* Handle navigation to another screen for selecting input
  Future<T?> _navigator<T>(Widget screen) async {
    return await Navigator.of(context).push<T>(
      AnimationUtils.createBottomToTopRoute(screen),
    );
  }

  //* Handle date picker
  Future<void> _onSelectedDate() async {
    final pickedDate = await _navigator(BlaDatePicker(initDate: departureDate));
    if (pickedDate != null) {
      setState(() => departureDate = pickedDate);
    }
  }

  //* Handle select departure location
  void _onSelectDeparture() async {
    Location? selectedLocation = await _navigator(BlaLocationPicker(
      initLocation: departure,
    ));

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  //* Handle select arrival location
  void _onSelectArrival() async {
    Location? selectedLocation = await _navigator(BlaLocationPicker(
      initLocation: arrival,
    ));

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  //* Handle select num of seats
  void _onSelectSeat() async {
    int? selectedSeat =
        await _navigator(RidePrefRequestSeat(requestedSeats: requestedSeats));

    if (selectedSeat != null) {
      setState(() {
        requestedSeats = selectedSeat;
      });
    }
  }

  // * Handlle switching departure and arrival locations
  void _onSwitchLocations() {
    setState(() {
      if (departure != null && arrival != null) {
        final Location temp = departure!;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  // * Handle on submit
  void _onSearchButtonPressed() {
      //* 1 - Validate input
    if (departure != null &&
        arrival != null &&
        departure != arrival &&
        requestedSeats > 0) {
      //* 2 - Create new ride through input (if input valid)
      final RidePref ridePref = RidePref(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );

      //* 3 - Navigate to ride screen
      Navigator.of(context)
          .push(AnimationUtils.createBottomToTopRoute(RideScreen(
        initialRidePref: ridePref,
      )));
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //* 1 - Select Departure Location
        RidePrefInputTile(
          isPlaceHolder: showDeparturePLaceHolder,
          text: departureLabel,
          prefixIcon: Icons.location_on,
          onPressed: _onSelectDeparture,
          suffixIcon: switchVisible ? Icons.swap_vert : null,
          onSuffixIconPressed: switchVisible ? _onSwitchLocations : null,
        ),
        const BlaDivider(),

        //* 2 - Select Arrival Location
        RidePrefInputTile(
          isPlaceHolder: showArrivalPLaceHolder,
          text: arrivalLabel,
          prefixIcon: Icons.location_on,
          onPressed: _onSelectArrival,
        ),
        const BlaDivider(),

        //* 3 - Select Departure Date
        RidePrefInputTile(
          text: dateLabel,
          prefixIcon: Icons.calendar_month,
          onPressed: _onSelectedDate,
        ),
        const BlaDivider(),

        //* 4 - Select Number Seats
        RidePrefInputTile(
            text: requestedSeats.toString(),
            onPressed: _onSelectSeat,
            prefixIcon: Icons.person_outline_rounded),
        BlaDivider(),
        const SizedBox(height: 16),

        //* 5 - Submit Form by Clicking Search Button
        BlaButton(
          onPressed: _onSearchButtonPressed,
          text: 'Search',
        ),
      ],
    );
  }
}
