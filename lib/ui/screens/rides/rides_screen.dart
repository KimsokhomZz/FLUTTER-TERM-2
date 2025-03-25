import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/ui/provider/ride_prefs_provider.dart';
import 'package:flutter_workspace_term2/service/rides_service.dart';
import 'package:provider/provider.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';

import '../../../model/ride/ride.dart';
import '../../../model/ride/ride_pref.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///

class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});

  onRidePrefSelected(BuildContext context, RidePreference newPreference) async {
    // 1 - Read the RidesPreferencesProvider
    final provider = context.read<RidesPreferencesProvider>();

    // 2 - Call the provider setCurrentPreferrence
    provider.setCurrentPreferrence(newPreference);
  }

  void onPreferencePressed(
      BuildContext context, RidePreference? currentPreference) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null && context.mounted) {
      context
          .read<RidesPreferencesProvider>()
          .setCurrentPreferrence(newPreference);
    }
  }

  void onFilterPressed() {
    //Logic
  }

  void onBackPressed(BuildContext context) {
    // Back to the previous screen
    Navigator.of(context).pop();
  }

  // Correct filter
  final RideFilter currentFilter = RideFilter();

  @override
  Widget build(BuildContext context) {
    // 1 - Watch the RidesPreferencesProvider
    final provider = context.watch<RidesPreferencesProvider>();
    // 2 - Get the current preference
    final RidePreference? currentPreference = provider.currentPreference;
    // 3 - Get the list of available rides regarding the current ride preference
    if (currentPreference == null) {
      return const Center(child: Text('No ride preference found'));
    }
    List<Ride> matchingRides =
        RidesService.instance.getRidesFor(currentPreference, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: () => onBackPressed(context),
              onPreferencePressed: () =>
                  onPreferencePressed(context, currentPreference),
              onFilterPressed: onFilterPressed,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
