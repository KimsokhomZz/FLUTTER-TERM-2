import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/Exercise-2/provider/color_tap_provider.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("StatisticsScreen rebuild");
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Consumer<ColorTapModel>(
          builder: (context, colorTapModel, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${colorTapModel.redTapCount}',
                    style: TextStyle(fontSize: 24)),
                Text('Blue Taps: ${colorTapModel.blueTapCount}',
                    style: TextStyle(fontSize: 24)),
              ],
            );
          },
        ),
      ),
    );
  }
}
