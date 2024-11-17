import 'package:flutter/material.dart';

class FmDropdownMenu extends StatefulWidget {
  
  final String dropdownValue;
  final List<String> dropdownList;
  final ValueChanged<String> onChanged;
  const FmDropdownMenu(
      {super.key,
      required this.dropdownList,
      required this.dropdownValue,
      required this.onChanged});

  @override
  State<StatefulWidget> createState() => _DropdownMenu();
}

class _DropdownMenu extends State<FmDropdownMenu> {
   String _dropdownValue = "";
  @override
  Widget build(BuildContext context) {
    _dropdownValue = widget.dropdownValue;
    return DropdownMenu<String>(
      initialSelection: _dropdownValue,
      onSelected: (String? value) {
        setState(() {
          _dropdownValue = value!;
        });
        widget.onChanged(_dropdownValue);
      },
      dropdownMenuEntries:
          widget.dropdownList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry(value: value, label: value);
      }).toList(),
    );
  }
}
