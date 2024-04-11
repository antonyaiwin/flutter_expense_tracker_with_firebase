import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/add_record_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:flutter_expense_tracker/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

import 'widgets/record_type_radio_button.dart';

class AddRecordScreen extends StatelessWidget {
  const AddRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('build');
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Add Record',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Consumer<AddRecordScreenController>(
              builder: (context, controller, child) {
                return RecordTypeRadioButton(
                  selectedIndex: controller.selectedIndex,
                  onChanged: (newValue) {
                    context
                        .read<AddRecordScreenController>()
                        .recordTypeIndexChanged(newValue);
                  },
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 30),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: context.read<AddRecordScreenController>().formKey,
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Amount'),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: context
                                  .read<AddRecordScreenController>()
                                  .amountController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Amount',
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    double.tryParse(value) == null) {
                                  return 'Please enter an amount';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 10),
                            const Text('Category'),
                            const SizedBox(height: 5),
                            Consumer<AddRecordScreenController>(
                              builder: (context, controller, child) {
                                return DropdownButtonFormField<String>(
                                  value: controller.selectedCategory,
                                  decoration: const InputDecoration(
                                    hintText: 'Select Category',
                                    isDense: true,
                                  ),
                                  items: controller.categoryItems
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    context
                                        .read<AddRecordScreenController>()
                                        .categoryChanged(value);
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a category';
                                    }
                                    return null;
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text('Date'),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: context
                                  .read<AddRecordScreenController>()
                                  .dateController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Select Date',
                                suffixIcon: Icon(Icons.calendar_month),
                                isDense: true,
                              ),
                              onTap: () {
                                _dateFieldClicked(context);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            const Text('Notes'),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: context
                                  .read<AddRecordScreenController>()
                                  .notesController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Notes',
                                isDense: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a note';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                if (context
                                    .read<AddRecordScreenController>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context
                                      .read<AddRecordScreenController>()
                                      .addData(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Data added successfully'),
                                    ),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Ink(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                  color: ColorConstants.black26,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add Record',
                                    style: TextStyle(
                                      color: ColorConstants.primaryWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dateFieldClicked(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime(1970, 1, 1),
      lastDate: DateTime(2100, 1, 1),
      initialDate: DateTime.now(),
    );
    if (date != null && context.mounted) {
      var time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (time != null) {
        date = date.add(Duration(hours: time.hour, minutes: time.minute));
      }
      if (context.mounted) {
        context.read<AddRecordScreenController>().dateSelected(date);
      }
    }
  }
}
