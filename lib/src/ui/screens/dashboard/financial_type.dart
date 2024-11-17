import 'package:flutter/material.dart';

class FinancialType extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const FinancialType({super.key, required this.title, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: Text(title)),
              Expanded(
                  flex: 1,
                  child: IconButton(
                    color: Colors.red,
                    onPressed: () {
                      onDelete();
                    },
                    icon: const Icon(Icons.delete),
                  )),
            ],
          ),
          const Divider(
            thickness: 0.2,
            color: Colors.blueGrey,
          )
        ]));
  }
}
