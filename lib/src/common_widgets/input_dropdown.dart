import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key? key,
    this.labelText,
    required this.valueText,
    required this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String? labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onPressed != null;
    final colorScheme = Theme.of(context).colorScheme;
    final valuecolor = enabled
        ? null
        : colorScheme.onSurface.withOpacity(0.38);
    final fillcolor =
        enabled ? null : colorScheme.onSurface.withOpacity(0.04);

    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          enabled: enabled,
          fillColor: fillcolor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle.copyWith(color: valuecolor)),
            Icon(Icons.arrow_drop_down, color: valuecolor),
          ],
        ),
      ),
    );
  }
}
