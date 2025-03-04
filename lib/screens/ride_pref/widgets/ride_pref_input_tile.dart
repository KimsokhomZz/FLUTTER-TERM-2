import 'package:flutter/material.dart';
import 'package:flutter_workspace_term2/theme/theme.dart';
import 'package:flutter_workspace_term2/widgets/actions/bla_icon_button.dart';

///
/// This tile represents a selectable tile on the Ride Preference screen
///

class RidePrefInputTile extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData prefixIcon;

  // If true the text is displayed ligher
  final bool isPlaceHolder;

  // Suffix button for handling switching location and can be optional
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  const RidePrefInputTile({
    super.key,
    required this.text,
    required this.onPressed,
    required this.prefixIcon,
    this.suffixIcon, //optional
    this.onSuffixIconPressed, //optional
    this.isPlaceHolder = false,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor =
        isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

    return ListTile(
      onTap: onPressed,
      title: Text(
        text,
        style: BlaTextStyles.button.copyWith(color: textColor),
      ),
      leading: Icon(
        prefixIcon,
        size: BlaSize.icon,
        color: BlaColors.iconLight,
      ),
      trailing: suffixIcon != null
          ? BlaIconButton(icon: suffixIcon, onPressed: onSuffixIconPressed)
          : null,
    );
  }
}
