import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon.income({
    super.key,
  }) : color = ColorConstants.primaryGreen;
  const TransactionIcon.expense({
    super.key,
  }) : color = ColorConstants.primaryRed;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.25),
      child: Icon(
        Icons.arrow_upward,
        color: color,
      ),
    );
  }
}
