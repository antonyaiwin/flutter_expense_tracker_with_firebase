import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon.income({
    super.key,
  })  : color = ColorConstants.primaryGreen,
        icon = Icons.arrow_upward;
  const TransactionIcon.expense({
    super.key,
  })  : color = ColorConstants.primaryRed,
        icon = Icons.arrow_downward;

  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.25),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
