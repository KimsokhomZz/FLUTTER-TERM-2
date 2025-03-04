import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/repository/locations_repository.dart';
import 'package:flutter_workspace_term2/screens/ride/ride_screen.dart';
import 'package:flutter_workspace_term2/utils/animations_util.dart';

import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';

import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatefulWidget {
  final LocationsRepository repository;
  const RidePrefScreen({super.key, required this.repository});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  onRidePrefSelected(RidePref newPreference) async {
    // 1 - Update the current preference
    RidePrefService.instance.setCurrentPreference(newPreference);

    // 2 - Navigate to the rides screen (with a buttom to top animation)
    await Navigator.of(context)
        .push(AnimationUtils.createBottomToTopRoute(RidesScreen()));

    // 3 - After wait  - Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    RidePref? currentRidePreference =
        RidePrefService.instance.currentPreference;
    List<RidePref> pastPreferences =
        RidePrefService.instance.getPastPreferences();

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
              padding: EdgeInsets.all(BlaSpacings.m),
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(
                    BlaSpacings.radius), // Rounded corners
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 2.1 Display the Form to input the ride preferences
                  RidePrefForm(
                    initialPreference: currentRidePreference,
                    onSubmit: onRidePrefSelected,
                    repository: widget.repository,
                  ),
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
                        onPressed: () =>
                            onRidePrefSelected(pastPreferences[index]),
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
