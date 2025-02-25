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
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(
              icon,
              size: 20,
              color: isPrimary ? BlaColors.white : BlaColors.primary,
            )
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: BlaTextStyles.button.copyWith(
          color: isPrimary ? BlaColors.white : BlaColors.primary,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: isPrimary ? BlaColors.primary : BlaColors.white,
        foregroundColor: isPrimary ? BlaColors.white : BlaColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: isPrimary ? BorderSide.none : BorderSide(color: BlaColors.neutralLighter.withOpacity(.5)),
        ),
      ),
    );
  }
}
