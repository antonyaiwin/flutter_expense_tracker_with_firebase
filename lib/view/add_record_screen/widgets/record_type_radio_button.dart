import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class RecordTypeRadioButton extends StatelessWidget {
  const RecordTypeRadioButton({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });
  final int selectedIndex;
  final void Function(int newValue)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RecordTypeContainer(
            title: 'Income',
            isSelected: selectedIndex == 0,
            onTap: () {
              onChanged?.call(0);
            },
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: RecordTypeContainer(
            title: 'Expense',
            isSelected: selectedIndex == 1,
            onTap: () {
              onChanged?.call(1);
            },
          ),
        ),
      ],
    );
  }
}

class RecordTypeContainer extends StatelessWidget {
  const RecordTypeContainer({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });
  final String title;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorConstants.black26.withOpacity(isSelected ? 1 : 0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? ColorConstants.primaryWhite
                  : ColorConstants.black26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
