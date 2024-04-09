import 'package:flutter/material.dart';

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
            Text(
              '\$14,564',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: ColorConstants.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: TotalCard(
                    amount: '2653',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TotalCard(
                    isIncome: false,
                    amount: '2656',
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
