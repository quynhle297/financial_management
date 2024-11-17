import 'package:financial_management/src/models/financial_record.dart';
import 'package:financial_management/src/services/firebase_service.dart';
import 'package:financial_management/src/ui/screens/common/date_picker.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';
import 'package:financial_management/src/ui/screens/dashboard/add_new_item_dialog.dart';
import 'package:financial_management/src/ui/screens/dashboard/financial_record_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  List<Widget> listItem = [];
  String? _startDate;
  String? _endDate;
  List<FinancialRecord> records = [];

  DateTime now = DateTime.now();
  DateTime get today => DateTime(now.year, now.month, 1);

  void initDate() {
    _startDate = DateFormat('yyyy-MM-dd').format(today);
    _endDate = DateFormat('yyyy-MM-dd').format(now);
  }

  final FirebaseService _firebaseService = FirebaseService();

  void _fetchRecordsByDate(String? startDate, String? endDate) async {
    // fetch data from start date to end date

    if (startDate == null || endDate == null) {
      records = List.empty();
    } else {
      DateTime start = DateFormat("yyyy-MM-dd").parse(startDate);
      DateTime end = DateFormat("yyyy-MM-dd").parse(endDate);
      if (end.isAfter(start)) {
        records = await _firebaseService.getRecordsByDate(start, end);
        getListRecordView(records);
      } else {
        setState(() {
          records = List.empty();
        });
      }
    }
  }

  void getListRecordView(List<FinancialRecord> list) {
    List<FinancialItem> listRecordViews = [];
    for (var element in list) {
      listRecordViews.add(getFinancialItem(element));
    }
    setState(() {
      listItem = listRecordViews;
    });
  }

  FinancialItem getFinancialItem(FinancialRecord record) {
    int itemIndex = 0;
    return FinancialItem(
      financialRecord: record,
      onEdit: (value) => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddItemDialog(
                isUpdateRecord: true,
                record: record,
                onDataChange: (updatedRecord) => {
                  itemIndex =
                      records.indexWhere((item) => item.id == record.id),
                  debugPrint("itemIdex: ${record.id} record: ${updatedRecord.toString()}"),
                  if (itemIndex != -1) {
                    records[itemIndex] = updatedRecord,
                    getListRecordView(records)},
                },
              );
            })
      },
      onDelete: (value) => {
        _firebaseService.deleteRecord(record),
        records.remove(record),
        getListRecordView(records)
      },
    );
  }

  @override
  void initState() {
    // init date from 1rst of current month to current day
    super.initState();
    initDate();
    setState(() {
      _fetchRecordsByDate(_startDate, _endDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: DatePicker(
                title: Strings.from,
                originDate: _startDate!,
                onChanged: (value) {
                  _startDate = value;
                },
              )),
              Expanded(
                  child: DatePicker(
                title: Strings.to,
                originDate: _endDate!,
                onChanged: (value) {
                  _endDate = value;
                },
              )),
              FilledButton(
                onPressed: () {
                  _fetchRecordsByDate(_startDate, _endDate);
                },
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(Strings.search),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddItemDialog(
                      onDataChange: (record) => {
                        setState(() {
                          listItem.add(getFinancialItem(record));
                        })
                      },
                    );
                  });
            },
            icon: const Icon(Icons.add)),
        if (listItem.isNotEmpty)
          Expanded(
              child: ListView(
            children: listItem,
          ))
        else
          Text(
            'Error when get list records. Please re-check date time \n - Start date is $_startDate \n - End date is $_endDate',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.red),
          ),
      ],
    );
  }
}
