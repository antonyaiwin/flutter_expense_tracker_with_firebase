class RecordModel {
  int? id;
  String note;
  String category;
  double amount;
  DateTime date;
  bool isIncome;

  RecordModel({
    this.id,
    required this.note,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });

  RecordModel copyWith({
    int? id,
    String? note,
    String? category,
    double? amount,
    DateTime? date,
    bool? isIncome,
  }) {
    return RecordModel(
      id: id ?? this.id,
      note: note ?? this.note,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'note': note,
      'category': category,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'isIncome': isIncome,
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      id: map['id'] != null ? map['id'] as int : null,
      note: map['note'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      isIncome: map['isIncome'] == 1,
    );
  }
}
