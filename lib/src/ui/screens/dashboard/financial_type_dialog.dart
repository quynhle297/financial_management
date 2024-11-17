import 'package:financial_management/src/ui/screens/dashboard/financial_type.dart';
import 'package:financial_management/src/services/firebase_service.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';
import 'package:flutter/material.dart';

class FinancialTypeDialog extends StatefulWidget {
  final ValueChanged<List<String>> onChanged;
  const FinancialTypeDialog({super.key, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _FinancialTypeDialog();
}

class _FinancialTypeDialog extends State<FinancialTypeDialog> {
  final typeController = TextEditingController();
  List<String> types = [];

  void _fetchTypes() async {
    types = await FirebaseService().getAllTypes();
    setState(() {});
  }

  void updateListTypes(String type, isRemove) {
    setState(() {
      if (isRemove) {
        types.remove(type);
      } else {
        types.add(type);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchTypes();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listType = List.empty(growable: true);
    for (int i = 0; i < types.length; i++) {
      listType.add(FinancialType(
        title: types[i],
        onDelete: () => {
          FirebaseService().deleteType(types[i]),
          setState(() {
            updateListTypes(types[i], true);
          })
        },
      ));
    }
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
          width: 400,
          height: 600,
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    Strings.listType,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        Expanded(
                            flex: 2,
                            child: TextField(
                                controller: typeController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    hintText: Strings.typeName,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall))),
                        Expanded(
                          flex: 1,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: FilledButton(
                                  onPressed: () => {
                                        FirebaseService()
                                            .addType(typeController.text),
                                        updateListTypes(
                                            typeController.text, false)
                                      },
                                  child: const Text(Strings.add))),
                        )
                      ])),
                  Expanded(
                      child: ListView(
                    children: listType,
                  )),
                  FilledButton(
                      onPressed: () => {
                            widget.onChanged(types),
                            Navigator.of(context).pop()
                          },
                      child: const Text(Strings.close))
                ],
              ))),
    );
  }
}
