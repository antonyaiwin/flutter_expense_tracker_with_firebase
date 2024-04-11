import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController extends ChangeNotifier {
  final String databaseName = 'records.db';
  final String tableName = 'Records';
  late Database database;
  List<RecordModel> transactionsList = [];
  double totalIncome = 0;
  double totalExpense = 0;

  double get totalBalance => totalIncome - totalExpense;

  DatabaseController() {
    initDB();
  }

  Future<void> initDB() async {
    // open the database
    database = await openDatabase(databaseName, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, note TEXT, category TEXT, amount REAL, date INTEGER, isIncome INTEGER)');
    });
    getAllData();
  }

  // get all data from table, total income,total expense
  Future<void> getAllData() async {
    var data =
        await database.rawQuery('SELECT * FROM $tableName ORDER BY date DESC');
    log(data.toString());
    transactionsList = data.map((e) => RecordModel.fromMap(e)).toList();
    List<Map<String, dynamic>> totalIncomeMap = await database.rawQuery(
        'SELECT SUM(amount) as total_income FROM $tableName WHERE isIncome = ?',
        [true]);
    totalIncome = totalIncomeMap[0]['total_income'] ?? 0;
    List<Map<String, dynamic>> totalExpenseMap = await database.rawQuery(
        'SELECT SUM(amount) as total_expense FROM $tableName WHERE isIncome = ?',
        [false]);
    totalExpense = totalExpenseMap[0]['total_expense'] ?? 0;
    notifyListeners();
  }

// add data to database table
  Future<void> addData(RecordModel item) async {
    await database.rawInsert(
        'INSERT INTO $tableName(note, category, amount, date, isIncome) VALUES(?, ?, ?, ?, ?)',
        [
          item.note,
          item.category,
          item.amount,
          item.date.millisecondsSinceEpoch,
          item.isIncome
        ]);
    await getAllData();
  }

  // delete data from table
  Future<void> deleteData(int id) async {
    await database.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
    await getAllData();
  }

  // delete data from table
  Future<void> editData(var id, RecordModel item) async {
    int count = await database.rawUpdate(
        'UPDATE $tableName SET note = ?, category = ?, amount = ?, date = ?, isIncome = ? WHERE id = ?',
        [
          item.note,
          item.category,
          item.amount,
          item.date.millisecondsSinceEpoch,
          item.isIncome
        ]);
    log('updated: $count');
    await getAllData();
  }
}
