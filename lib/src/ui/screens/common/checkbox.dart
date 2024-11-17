import 'package:flutter/material.dart';

class Checkboxwithtext extends StatefulWidget {
  final String title;
  const Checkboxwithtext({super.key, required this.title});
  @override
  State<StatefulWidget> createState() => _CheckboxWithText();
}

class _CheckboxWithText extends State<Checkboxwithtext> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            }),
        Text(widget.title),
      ],
    );
  }
}
