import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';
import 'package:flutter_workspace_term2/utils/date_time_util.dart';
import 'package:flutter_workspace_term2/widgets/actions/bla_button.dart';
import 'package:intl/intl.dart';

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
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;

    //  * Here we initialize the text controllers
    _departureController.text = departure?.name ?? '';
    _arrivalController.text = arrival?.name ?? '';
    _seatController.text = requestedSeats.toString();
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // * Switch departure and arrival locations funciton
  void _switchLocations() {
    setState(() {
      final Location temp = departure!;
      departure = arrival;
      arrival = temp;

      // * Update the new departure and arrival locations to text controllers
      _departureController.text = departure?.name ?? '';
      _arrivalController.text = arrival?.name ?? '';
    });
  }

  // * Increase num of seats function
  void _increaseSeats() {
    setState(() {
      requestedSeats++;
      _seatController.text = requestedSeats.toString();
    });
  }

  // * Decrease num of seats function
  void _decreaseSeats() {
    if (requestedSeats > 1) {
      setState(() {
        requestedSeats--;
        _seatController.text = requestedSeats.toString();
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
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
      Navigator.of(context).pop(ridePref);
    }
  }

  Future<Location?> _selectLocation(BuildContext context) async {
    // This Logic I will implement in Bla-005
    return null; // And I will replace this with the actual location selection
  }

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
      height: 400,
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
          ListTile(
            leading: Icon(
              Icons.radio_button_unchecked,
              color: BlaColors.neutralDark,
            ),
            title: TextField(
              controller: _departureController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select departure location',
                border: InputBorder.none,
              ),
              onTap: () async {
                final Location? selectedDeparture =
                    await _selectLocation(context);
                if (selectedDeparture != null) {
                  setState(() {
                    departure = selectedDeparture;
                    _departureController.text = selectedDeparture.name;
                  });
                }
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.swap_vert, color: BlaColors.primary),
              onPressed: _switchLocations,
            ),
          ),
          Divider(),

          // * Arrival Location Form
          ListTile(
            leading: Icon(Icons.radio_button_unchecked,
                color: BlaColors.neutralDark),
            title: TextField(
              controller: _arrivalController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Select arrival location',
                border: InputBorder.none,
              ),
              onTap: () async {
                final selectedlocation = await _selectLocation(context);
                if (selectedlocation != null) {
                  setState(() {
                    arrival = selectedlocation;
                    _arrivalController.text = selectedlocation.name;
                  });
                }
              },
            ),
          ),
          Divider(),

          // * Date Form
          ListTile(
            leading: Icon(
              Icons.calendar_today,
              color: BlaColors.neutralDark,
            ),
            title: Text(DateTimeUtils.formatDateTime(departureDate)),
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: departureDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (pickedDate != null) {
                setState(() => departureDate = pickedDate);
              }
            },
          ),
          Divider(),

          // * Seats Form
          ListTile(
            leading: Icon(Icons.person, color: BlaColors.neutralDark),
            title: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: _decreaseSeats,
                ),
                Expanded(
                  child: TextField(
                    controller: _seatController,
                    textAlign: TextAlign.center,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: _increaseSeats,
                ),
              ],
            ),
          ),
          Divider(),
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
