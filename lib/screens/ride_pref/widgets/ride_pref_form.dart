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
  const RidePrefForm(
      {super.key, required this.initialPreference, required this.onSubmit});

  final RidePref? initialPreference;
  final Function(RidePref preference) onSubmit;

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
    if (widget.initialPreference != null) {
      RidePref current = widget.initialPreference!;
      departure = current.departure;
      arrival = current.arrival;
      departureDate = current.departureDate;
      requestedSeats = current.requestedSeats;
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
    // 1- Select a date
    final pickedDate = await _navigator(BlaDatePicker(initDate: departureDate));

    // 2- Update the form if needed
    if (pickedDate != null) {
      setState(() => departureDate = pickedDate);
    }
  }

  //* Handle select departure location
  void _onSelectDeparture() async {
    // 1- Select a location
    Location? selectedLocation = await _navigator(BlaLocationPicker(
      initLocation: departure,
    ));

    // 2- Update the form if needed
    if (selectedLocation != null) {
      setState(() => departure = selectedLocation);
    }
  }

  //* Handle select arrival location
  void _onSelectArrival() async {
    // 1- Select a location
    Location? selectedLocation = await _navigator(BlaLocationPicker(
      initLocation: arrival,
    ));

    // 2- Update the form if needed
    if (selectedLocation != null) {
      setState(() => arrival = selectedLocation);
    }
  }

  //* Handle select num of seats
  void _onSelectSeat() async {
    // 1- Choose the number of seats
    int? selectedSeat =
        await _navigator(RidePrefRequestSeat(requestedSeats: requestedSeats));

    // 2- Update the form if needed
    if (selectedSeat != null) {
      setState(() => requestedSeats = selectedSeat);
    }
  }

  // * Handlle switching departure and arrival locations
  void _onSwitchLocations() {
    setState(() {
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // * Handle on submit
  void _onSearchButtonPressed() {
    // 1- Validate input
    if (departure != null &&
        arrival != null &&
        departure != arrival &&
        requestedSeats > 0) {
      // 2- Create new ride through input (if input valid)
      final RidePref newPreference = RidePref(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );

      //// 3 - Navigate to ride screen
      // Navigator.of(context)
      //     .push(AnimationUtils.createBottomToTopRoute(RideScreen(
      //   initialRidePref: ridePref,
      // )));

      // 3 - Callback withg the new preference
      widget.onSubmit(newPreference);
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
        //* 1- Select Departure Location
        RidePrefInputTile(
          isPlaceHolder: showDeparturePLaceHolder,
          text: departureLabel,
          prefixIcon: Icons.location_on,
          onPressed: _onSelectDeparture,
          suffixIcon: switchVisible ? Icons.swap_vert : null,
          onSuffixIconPressed: switchVisible ? _onSwitchLocations : null,
        ),
        const BlaDivider(),

        //* 2- Select Arrival Location
        RidePrefInputTile(
          isPlaceHolder: showArrivalPLaceHolder,
          text: arrivalLabel,
          prefixIcon: Icons.location_on,
          onPressed: _onSelectArrival,
        ),
        const BlaDivider(),

        //* 3- Select Departure Date
        RidePrefInputTile(
          text: dateLabel,
          prefixIcon: Icons.calendar_month,
          onPressed: _onSelectedDate,
        ),
        const BlaDivider(),

        //* 4- Select Number Seats
        RidePrefInputTile(
            text: requestedSeats.toString(),
            onPressed: _onSelectSeat,
            prefixIcon: Icons.person_outline_rounded),
        BlaDivider(),
        const SizedBox(height: 16),

        //* 5- Submit Form by Clicking Search Button
        BlaButton(
          onPressed: _onSearchButtonPressed,
          text: 'Search',
        ),
      ],
    );
  }
}
