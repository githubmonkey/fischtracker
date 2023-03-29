import 'dart:async';

import 'package:fischtracker/src/common_widgets/input_dropdown.dart';
import 'package:fischtracker/src/utils/format.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
   const DateTimePicker({
    Key? key,
    required this.labelText,
    required this.selectedDate,
    required this.selectedTime,
    this.onSelectedDate,
    this.onSelectedTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<TimeOfDay>? onSelectedTime;

  Future<void> _selectDate(BuildContext context) async {
    if (onSelectedDate == null) return;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2019, 1),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate?.call(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (onSelectedTime == null) return;
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime) {
      onSelectedTime?.call(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.bodyLarge!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText,
            valueText: Format.date(selectedDate),
            valueStyle: valueStyle,
            onPressed:
                onSelectedDate == null ? null : () => _selectDate(context),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 4,
          child: InputDropdown(
            labelText: '',
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed:
                onSelectedTime == null ? null : () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}
