import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import 'transaction_icon.dart';

class TotalCard extends StatelessWidget {
  const TotalCard({
    super.key,
    this.isIncome = true,
  });
  final bool isIncome;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConstants.primaryWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isIncome
              ? const TransactionIcon.income()
              : const TransactionIcon.expense(),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isIncome ? 'Income' : 'Expense',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: isIncome
                          ? ColorConstants.primaryGreen
                          : ColorConstants.primaryRed,
                    ),
              ),
              Consumer<DatabaseController>(
                builder: (context, value, child) {
                  return Text(
                    '\$${isIncome ? value.totalIncome.toStringAsFixed(0) : value.totalExpense.toStringAsFixed(0)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
