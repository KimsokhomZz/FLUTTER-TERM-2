import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';

class BlaDatePicker extends StatefulWidget {
  final DateTime initDate;
  const BlaDatePicker({super.key, required this.initDate});

  @override
  State<BlaDatePicker> createState() => _BlaDatePickerState();
}

class _BlaDatePickerState extends State<BlaDatePicker> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarDatePicker(
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
        onDateChanged: (date) => {
          setState(() => selectedDate = date,)
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(selectedDate),
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
