import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/provider/async_value.dart';
import 'package:flutter_workspace_term2/provider/ride_prefs_provider.dart';
import 'package:flutter_workspace_term2/ui/widgets/display/bla_error_screen.dart';
import 'package:provider/provider.dart';

import '../../../model/ride/ride_pref.dart';
// import '../../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';

import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///

class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    // 1 - Read the RidesPreferencesProvider
    final provider = context.read<RidesPreferencesProvider>();

    // 2 - Call the provider setCurrentPreferrence
    provider.setCurrentPreferrence(newPreference);

    // 3 - Navigate to the rides screen (with a buttom to top animation)
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // 1 - Watch the RidesPreferencesProvider
    final provider = context.watch<RidesPreferencesProvider>();
    // 2 - Get the current preference
    final RidePreference? currentRidePreference = provider.currentPreference;
    // 3 - Get the history preferences
    final List<RidePreference> pastPreferences = provider.preferencesHistory;

    // Get past preferences state
    final pastPreferencesState = provider.pastPreferences;

    if (pastPreferencesState == null ||
        pastPreferencesState.state == AsyncValueState.loading) {
      return BlaError(message: "Loading...");
    } else if (pastPreferencesState.state == AsyncValueState.error) {
      return BlaError(message: "No connection. Try later.");
    } else if (pastPreferencesState.state == AsyncValueState.success) {
      return Stack(
        children: [
          // 1 - Background  Image
          BlaBackground(),

          // 2 - Foreground content
          Column(
            children: [
              SizedBox(height: BlaSpacings.m),
              Text(
                "Your pick of rides at low price",
                style: BlaTextStyles.heading.copyWith(color: Colors.white),
              ),
              SizedBox(height: 100),
              Container(
                margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 2.1 Display the Form to input the ride preferences
                    RidePrefForm(
                        initialPreference: currentRidePreference,
                        onSubmit: (pref) => onRidePrefSelected(context, pref)),
                    SizedBox(height: BlaSpacings.m),

                    // 2.2 Optionally display a list of past preferences
                    SizedBox(
                      height: 200, // Set a fixed height
                      child: ListView.builder(
                        shrinkWrap: true, // Fix ListView height issue
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: pastPreferences.length,
                        itemBuilder: (ctx, index) => RidePrefHistoryTile(
                          ridePref: pastPreferences[index],
                          onPressed: () => onRidePrefSelected(
                              context, pastPreferences[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return BlaError(message: "Unknown state");
    }
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
