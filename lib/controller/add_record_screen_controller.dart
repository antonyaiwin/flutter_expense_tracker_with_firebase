import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'database_controller.dart';

class AddRecordScreenController with ChangeNotifier {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedIndex = 0;
  String? selectedCategory;
  DateTime? selectedDate;
  List<String> incomeCategoryItems = [
    'Salary',
    'Sale',
    'Lottery',
    'Refunds',
  ];
  List<String> expenseCategoryItems = [
    'Bills',
    'Clothing',
    'Food',
    'Education',
    'Shopping'
  ];

  // function for toggling between income and expenses
  void recordTypeIndexChanged(int value) {
    selectedIndex = value;
    selectedCategory = null;
    notifyListeners();
  }

  // function for saving selected category in selectedCategory
  void categoryChanged(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  // function for saving selected category in selectedCategory
  void dateSelected(DateTime value) {
    selectedDate = value;
    dateController.text =
        DateFormat('MMM dd, yyyy hh:mm a').format(selectedDate!);
  }

  // function to add data
  void addData(BuildContext context) {
    context.read<DatabaseController>().addData(
          getRecordModel(),
        );
  }

  RecordModel getRecordModel() {
    return RecordModel(
      note: notesController.text,
      category: selectedCategory!,
      amount: double.parse(amountController.text),
      date: selectedDate!,
      isIncome: selectedIndex == 0,
    );
  }

  // getter function to get corresponding category list according to selected type
  List<String> get categoryItems =>
      selectedIndex == 0 ? incomeCategoryItems : expenseCategoryItems;
}
