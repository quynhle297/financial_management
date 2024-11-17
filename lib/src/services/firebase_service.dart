import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_management/src/models/financial_record.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
//lequynhkma@gmail.com

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Types
  Future<List<String>> getAllTypes() async {
    if (user != null) {
      DocumentSnapshot snapshot =
          (await _firestore.collection(user!.uid).doc('types').get());
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        List<String> types = List<String>.from(data?['types'] ?? []);
        return types;
      } else {
        return addDefaultList();
      }
    }
    return List.empty();
  }

  Future<List<String>> addDefaultList() async {
    List<String> types = [
      Strings.saving,
      Strings.expenses,
      Strings.income,
      Strings.invest
    ];
    for (int i = 0; i < types.length; i++) {
      await _firestore.collection(user!.uid).doc('types').set({
        'types': FieldValue.arrayUnion([types[i]])
      }, SetOptions(merge: true));
    }
    return getAllTypes();
  }

  Future<void> addType(String type) async {
    try {
      await _firestore.collection(user!.uid).doc('types').set({
        'types': FieldValue.arrayUnion([type])
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error adding new record: $e');
    }
  }

  Future<void> deleteType(String type) async {
    try {
      await _firestore.collection(user!.uid).doc('types').set({
        'types': FieldValue.arrayRemove([type])
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error delete type: $e');
    }
  }

// manage records
  Future<List<FinancialRecord>> getAllRecords() async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(user!.uid)
          .doc('records')
          .get(const GetOptions(source: Source.server));
      if (doc.exists) {
        List<dynamic> records = doc['records'];
        return records
            .map((record) => FinancialRecord.fromMap(record))
            .toList(); // Cast to list of maps
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error getting data: $e');
    }
  }

  Future<List<FinancialRecord>> getRecordsByDate(
      DateTime startDate, DateTime endDate) async {
    List<FinancialRecord> list = List.empty(growable: true);
    try {
      list = await getAllRecords();
      List<FinancialRecord> newList = List.empty(growable: true);
      newList.addAll(list);
      for (var item in list) {
        if (item.date != "") {
          DateTime date = DateTime.parse(item.date);
          if (date.isBefore(startDate) || date.isAfter(endDate)) {
            newList.remove(item);
          }
        }
      }
      return newList;
    } catch (e) {
      throw Exception('Error getting all records: $e');
    }
  }

  Future<void> addRecord(FinancialRecord record) async {
    try {
      await _firestore.collection(user!.uid).doc('records').set({
        'records': FieldValue.arrayUnion([record.toMap()])
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error adding new record: $e');
    }
  }

  Future<void> deleteRecord(FinancialRecord record) async {
    try {
      await _firestore.collection(user!.uid).doc('records').set({
        'records': FieldValue.arrayRemove([record.toMap()])
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error delete record: $e');
    }
  }

  Future<void> editRecord(FinancialRecord updatedecord) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(user!.uid).doc('records').get();
      if (snapshot.exists) {
        List<dynamic> records = snapshot.get('records');
        debugPrint('records = ${records.length}');
        List<dynamic> updatedRecords = records.map((record) {
          if (record['id'] == updatedecord.id) {
            return updatedecord.toMap();
          }
          return record as Map<String, dynamic>;
        }).toList();

        await _firestore.collection(user!.uid).doc('records').update({
          'records': updatedRecords,
        });
      }
    } catch (e) {
      throw Exception('Error getting all records: $e');
    }
  }

  Future<void> deleteMultiRecord(List<FinancialRecord> records) async {
    try {} catch (e) {
      throw Exception('Error getting all records: $e');
    }
  }
}
