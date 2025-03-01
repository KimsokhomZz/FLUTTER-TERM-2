import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/screens/ride/ride_screen.dart';
import 'package:flutter_workspace_term2/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:flutter_workspace_term2/service/locations_service.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';
import 'package:flutter_workspace_term2/utils/animations_util.dart';
import 'package:flutter_workspace_term2/utils/date_time_util.dart';
import 'package:flutter_workspace_term2/widgets/actions/bla_button.dart';
import 'package:flutter_workspace_term2/widgets/display/bla_divider.dart';
import 'package:flutter_workspace_term2/widgets/inputs/bla_location_picker.dart';

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

  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _arrivalController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();

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

  // // * Handle user input (ride pref input)
  // Future<void> _onArrivalLocationSelect() async {
  //   final selectedlocation = await _selectLocation(context);
  //   if (selectedlocation != null) {
  //     setState(() {
  //       arrival = selectedlocation;
  //       _arrivalController.text = selectedlocation.name;
  //     });
  //   }
  // }

  // Future<void> _onDepartureLocationSelect() async {
  //   final Location? selectedDeparture = await _selectLocation(context);
  //   if (selectedDeparture != null) {
  //     setState(() {
  //       departure = selectedDeparture;
  //       _departureController.text = selectedDeparture.name;
  //     });
  //   }
  // }

  Future<void> _onSelectedDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() => departureDate = pickedDate);
    }
  }

  void _onSelectDeparture() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
        initLocation: departure,
      )),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void _onSelectArrival() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
        initLocation: arrival,
      )),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  // * Switch departure and arrival locations funciton
  void _onSwitchLocations() {
    setState(() {
      if (departure != null && arrival != null) {
        final Location temp = departure!;
        departure = arrival;
        arrival = temp;
      }
    });
  }

  

  // * Handle on Submit
  void _onSearchButtonPressed() {
    if (departure != null &&
        arrival != null &&
        departure != arrival &&
        requestedSeats > 0) {
      final RidePref ridePref = RidePref(
        departure: departure!,
        departureDate: departureDate,
        arrival: arrival!,
        requestedSeats: requestedSeats,
      );
      // Navigator.of(context).pop(ridePref);
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

  @override
  void dispose() {
    _departureController.dispose();
    _arrivalController.dispose();
    _seatController.dispose();
    super.dispose();
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // * Departure Location Form
          RidePrefInputTile(
            isPlaceHolder: showDeparturePLaceHolder,
            text: departureLabel,
            prefixIcon: Icons.location_on,
            onPressed: _onSelectDeparture,
            suffixIcon: switchVisible ? Icons.swap_vert : null,
            onSuffixIconPressed:
                switchVisible ? _onSwitchLocations : null,
          ),
          const BlaDivider(),

          // * Arrival Location Form
          RidePrefInputTile(
            isPlaceHolder: showArrivalPLaceHolder,
            text: arrivalLabel,
            prefixIcon: Icons.location_on,
            onPressed: _onSelectArrival,
          ),
          const BlaDivider(),

          // * Date Form
          RidePrefInputTile(
            text: dateLabel,
            prefixIcon: Icons.calendar_month,
            onPressed: _onSelectedDate,
          ),
          const BlaDivider(),

          // * Seats Form
          ListTile(
            leading: Icon(Icons.person, color: BlaColors.neutralDark),
            title: Text('Number of Seat'),
          ),
          BlaDivider(),
          const SizedBox(height: 16),
          // * Search Button
          BlaButton(
            onPressed: _onSearchButtonPressed,
            text: 'Search',
          ),
        ],
      ),
    );
  }
}
