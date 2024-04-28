import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/add_record_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';
import 'package:flutter_expense_tracker/utils/functions.dart';
import 'package:flutter_expense_tracker/view/add_record_screen/add_record_screen.dart';
import 'package:provider/provider.dart';

class TransactionAlertDialog extends StatelessWidget {
  const TransactionAlertDialog({
    super.key,
    required this.item,
    required this.transactionId,
  });
  final RecordModel item;
  final String transactionId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: item.isIncome ? Colors.green : Colors.red,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme(
                  data: const IconThemeData(color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.close),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                          showDeleteDialog(context);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (context) => AddRecordScreenController(
                                  transactionId: transactionId,
                                  item: item,
                                ),
                                child: const AddRecordScreen(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.isIncome ? 'INCOME' : 'EXPENSE',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${item.isIncome ? '' : '-'}\$${item.amount}',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      getFormattedDate(item.date),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(text: 'Category : ', children: [
              TextSpan(
                text: item.category,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]),
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text.rich(
            TextSpan(text: 'Note : ', children: [
              TextSpan(
                text: item.note,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ]),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  //alert dialog for delete confirmation
  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool isDeleting = false;
        return AlertDialog(
          title: const Text('Are you sure to delete this transaction?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            StatefulBuilder(builder: (context, setState) {
              return TextButton(
                onPressed: isDeleting
                    ? null
                    : () async {
                        setState(() {
                          isDeleting = true;
                        });
                        await context
                            .read<DatabaseController>()
                            .deleteData(transactionId);
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                child: isDeleting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator())
                    : const Text('Yes'),
              );
            }),
          ],
        );
      },
    );
  }
}
