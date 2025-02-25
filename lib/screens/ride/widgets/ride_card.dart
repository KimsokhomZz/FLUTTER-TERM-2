import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {

  const RideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Departure: Nice", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Arrival: Cambridge", style: TextStyle(fontSize: 16)),
          Text("Time: 23:53", style: TextStyle(fontSize: 16)),
          Text("Seats Available: 22", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
