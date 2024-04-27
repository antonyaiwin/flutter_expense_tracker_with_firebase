import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';

class DatabaseController extends ChangeNotifier {
  final String collectionPath = 'records';
  late CollectionReference collection;
  double totalIncome = 0;
  double totalExpense = 0;

  double get totalBalance => totalIncome - totalExpense;

  DatabaseController() {
    initCollection();
  }

  Future<void> initCollection() async {
    // create collection reference object
    collection = FirebaseFirestore.instance.collection(collectionPath);
    addCollectionListener();
  }

  // adding snapshot listener for calculating total figures for income, expense and balance
  addCollectionListener() {
    collection.snapshots().listen((event) {
      log('snapshot listener');
      var docs = event.docs;
      totalIncome = docs.fold(
        0.0,
        (previousValue, element) => previousValue +=
            (element.data() as Map)['isIncome']
                ? (element.data() as Map)['amount']
                : 0.0,
      );
      totalExpense = docs.fold(
        0.0,
        (previousValue, element) => previousValue +=
            (element.data() as Map)['isIncome']
                ? 0.0
                : (element.data() as Map)['amount'],
      );
      notifyListeners();
    });
  }

  // add data to firebase collection
  Future<void> addData(RecordModel item) async {
    await collection.add(item.toMap());
  }

  // delete data from collection
  Future<void> deleteData(String id) async {
    await collection.doc(id).delete();
  }

  // edit data from in collection
  Future<void> editData(String id, RecordModel item) async {
    await collection.doc(id).set(item.toMap());
  }
}
