import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String title;
  final String originDate;
  final ValueChanged<String> onChanged;
  const DatePicker({super.key, required this.title, required this.onChanged, required this.originDate});

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;
  String date = "";
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.originDate;
  }

  // Function to call the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        date = _formatDate(_selectedDate!);
        textController.text = date ;
        widget.onChanged(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration.collapsed(hintText: 'date time'),
                  readOnly: true,
                  controller: textController,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: const Icon(Icons.calendar_month))
            ],
          )),
    );
  }
}

// Format date as 'yyyy-MM-dd'
String _formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
