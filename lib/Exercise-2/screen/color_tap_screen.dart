import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_workspace_term2/Exercise-2/provider/color_tap_provider.dart';

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("ColorTapScreen rebuild");
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Consumer<ColorTapModel>(
        builder: (context, colorTapModel, child) {
          return Column(
            children: [
              ColorTap(
                type: CardType.red,
                tapCount: colorTapModel.redTapCount,
                onTap: colorTapModel.incrementRedTapCount,
              ),
              ColorTap(
                type: CardType.blue,
                tapCount: colorTapModel.blueTapCount,
                onTap: colorTapModel.incrementBlueTapCount,
              ),
            ],
          );
        },
      ),
    );
  }
}

enum CardType { red, blue }

// ColorTap Widget
class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    print("ColorTap widget rebuild");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
