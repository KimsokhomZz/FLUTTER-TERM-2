import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isPrimary;

  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    // Computer the rendering
    Color backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    Color foregroundColor = isPrimary ? BlaColors.white : BlaColors.primary;
    Color iconColor = isPrimary ? BlaColors.white : BlaColors.primary;

    BorderSide border = isPrimary
        ? BorderSide.none
        : BorderSide(color: BlaColors.neutralLighter.withOpacity(.5));

    // Create the button icon - if any
    Widget handleIcon() {
      if (icon != null) {
        return Icon(
          icon,
          size: 20,
          color: iconColor,
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: handleIcon(),
      label: Text(
        text,
        style: BlaTextStyles.button.copyWith(
          color: foregroundColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: border,
        ),
      ),
    );
  }
}
