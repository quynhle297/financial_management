import 'package:financial_management/src/models/financial_record.dart';
import 'package:flutter/material.dart';

class FinancialItem extends StatelessWidget {
  final FinancialRecord financialRecord;
  final ValueChanged<FinancialRecord> onEdit;
  final ValueChanged<FinancialRecord> onDelete;

  const FinancialItem(
      {super.key,
      required this.financialRecord,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Text(
                      financialRecord.date,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                Expanded(
                  flex: 2,
                  child: Text(financialRecord.type,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                Expanded(
                    flex: 6,
                    child: Text(financialRecord.description,
                        style: Theme.of(context).textTheme.bodySmall)),
                Expanded(
                    flex: 2,
                    child: Text(financialRecord.amount,
                        style: Theme.of(context).textTheme.bodySmall)),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => {onEdit(financialRecord)},
                    iconSize: 24,
                    icon: const Icon(Icons.edit),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Warning"),
                              content: const Text(
                                  "Do you want to delete this record?"),
                              actions: [
                                TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("No")),
                                TextButton(
                                    onPressed: () => {
                                          onDelete(financialRecord),
                                          Navigator.of(context).pop()
                                        },
                                    child: const Text("Yes"))
                              ],
                            );
                          })
                    },
                    iconSize: 24,
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.blueGrey,
                ))
          ],
        ));
  }
}
