import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/screens/ride/widgets/ride_card.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';

class RideScreen extends StatelessWidget {
  const RideScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: BlaColors.neutralLight),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: BlaColors.greyLight,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RideCard(),
          ],
        ),
      ),
    );
  }
}


