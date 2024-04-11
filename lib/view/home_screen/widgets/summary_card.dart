import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import 'total_card.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: ColorConstants.black26,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Balance',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorConstants.primaryWhite,
                  ),
            ),
            Consumer<DatabaseController>(
              builder: (BuildContext context, DatabaseController value,
                  Widget? child) {
                return Text(
                  '\$${value.totalBalance.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: ColorConstants.primaryWhite,
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: TotalCard(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TotalCard(
                    isIncome: false,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
