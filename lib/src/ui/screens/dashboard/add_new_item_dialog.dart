import 'package:financial_management/src/constants/const.dart';
import 'package:financial_management/src/models/financial_record.dart';
import 'package:financial_management/src/ui/screens/common/date_picker.dart';
import 'package:financial_management/src/ui/screens/common/dropdown_menu.dart';
import 'package:financial_management/src/ui/screens/dashboard/financial_type_dialog.dart';
import 'package:financial_management/src/services/firebase_service.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItemDialog extends StatefulWidget {
  final ValueChanged<FinancialRecord> onDataChange;
  final bool? isUpdateRecord;
  final FinancialRecord? record;

  const AddItemDialog(
      {super.key,
      required this.onDataChange,
      this.record,
      this.isUpdateRecord});

  @override
  State<StatefulWidget> createState() => _AddItemDialog();
}

class _AddItemDialog extends State<AddItemDialog> {
  String dateController = "";
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  String typeController = "";

  List<String> listType = [];
  final FirebaseService _firebaseService = FirebaseService();

  List<String> types = [];
  void _fetchTypes() async {
    types = await _firebaseService.getAllTypes();
    setState(() {
      typeController = types.first;
      listType = types;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTypes();

    if (widget.isUpdateRecord == true) {
      descriptionController.text = widget.record!.description;
      amountController.text = widget.record!.amount;
      dateController = widget.record!.date;
      typeController = widget.record!.type;
    } else {
      dateController = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
          width: 400,
          height: 600,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(Strings.createNewItem),
                DatePicker(
                  title: Strings.pickDate,
                  originDate: dateController,
                  onChanged: (value) {
                    dateController = value;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: FmDropdownMenu(
                          dropdownList: listType,
                          dropdownValue: listType.first,
                          onChanged: (type) {
                            typeController = type;
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: FilledButton(
                              onPressed: () => {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return FinancialTypeDialog(
                                            onChanged: (List<String> types) {
                                              setState(() {
                                                listType = types;
                                              });
                                            },
                                          );
                                        }),
                                  },
                              child: const Text(Strings.editType)),
                        ))
                  ],
                ),
                TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: Strings.content,
                        hintStyle: Theme.of(context).textTheme.bodySmall)),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: Strings.price,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FilledButton(
                        onPressed: () {
                          FinancialRecord updatedRecord = FinancialRecord(
                            id: widget.record!.id,
                              date: dateController,
                              type: typeController,
                              description: descriptionController.text,
                              amount: amountController.text);
                          debugPrint('after edit: ${updatedRecord.toString()}');
                          if (widget.isUpdateRecord == true) {
                            // save edited record
                            _firebaseService.editRecord(updatedRecord);
                          } else {
                            //save new record
                            _firebaseService.addRecord(updatedRecord);
                          }
                          widget.onDataChange(updatedRecord);
                          Navigator.of(context).pop();
                        },
                        child: const Text(Strings.save)),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(Strings.cancel),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
