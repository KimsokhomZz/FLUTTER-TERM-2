import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';

class RidePrefRequestSeat extends StatefulWidget {
  final int requestedSeats;
  const RidePrefRequestSeat({super.key, required this.requestedSeats});

  @override
  State<RidePrefRequestSeat> createState() => _RidePrefRequestSeatState();
}

class _RidePrefRequestSeatState extends State<RidePrefRequestSeat> {
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    requestedSeats = widget.requestedSeats;
  }

  // * Increase num of seats function
  void _increaseSeats() {
    setState(() {
      requestedSeats++;
      // _seatController.text = requestedSeats.toString();
    });
  }

  // * Decrease num of seats function
  void _decreaseSeats() {
    if (requestedSeats > 1) {
      setState(() {
        requestedSeats--;
        // _seatController.text = requestedSeats.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Computer iconButton color before render
    Color decreaseButtonColor =
        requestedSeats == 1 ? BlaColors.disabled : BlaColors.primary;
    Color increaseButtonColor = BlaColors.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: BlaColors.primary,
          ),
          onPressed: () {
            Navigator.of(context).pop(requestedSeats);
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            'Number of seats to book',
            style: BlaTextStyles.heading.copyWith(
              color: BlaColors.neutralDark,
            ),
          ),
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: requestedSeats > 1 ? _decreaseSeats : null,
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                      size: 48,
                      color: decreaseButtonColor,
                    )),
                Text(
                  requestedSeats.toString(),
                  style: BlaTextStyles.heading.copyWith(
                    fontSize: 64,
                    color: BlaColors.neutralDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                    onPressed: _increaseSeats,
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      size: 48,
                      color: increaseButtonColor,
                    )),
              ],
            ),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(requestedSeats),
        backgroundColor: BlaColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: BlaColors.white,
        ),
      ),
    );
  }
}
