import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';

import '../../../utils/functions.dart';
import 'transaction_icon.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final RecordModel item;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              item.isIncome
                  ? const TransactionIcon.income()
                  : const TransactionIcon.expense(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.note,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      item.category,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${item.isIncome ? '' : '-'}\$${item.amount.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    getFormattedDate(item.date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
