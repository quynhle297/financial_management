import 'package:uuid/uuid.dart';

class FinancialRecord {
  String? id;
  String date;
  String type;
  String description;
  String amount;
  FinancialRecord(
      {String? id,
      required this.date,
      required this.type,
      required this.description,
      required this.amount})
      : id = id ?? const Uuid().v4();

  // Factory constructor to create a FinancialRecord object from Firestore data
  factory FinancialRecord.fromMap(Map<String, dynamic> data) {
    return FinancialRecord(
        id: data['id'],
        date: data['date'],
        type: data['type'] ?? '', // Provide a default value if null
        description: data['description'] ?? '',
        amount: data['amount']);
  }

  // Method to convert the FinancialRecord object back to a map (for saving/updating data)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'description': description,
      'amount': amount
    };
  }

  @override
  String toString() {

    return "FinancialRecord(id: $id, date: $date, type: $type, description: $description, amount: $amount)";
  }
}
