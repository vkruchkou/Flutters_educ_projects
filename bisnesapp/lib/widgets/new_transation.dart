import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransation extends StatefulWidget {
  final Function _addTransaction;
  const NewTransation(this._addTransaction, {super.key});

  @override
  State<NewTransation> createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _dateTime;

  void _submitData() {
    final String title = _titleController.text;
    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || _dateTime == null) {
      return;
    }
    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget._addTransaction(
        _titleController.text, double.parse(_amountController.text), _dateTime);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        borderOnForeground: false,
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 15,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Anmount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(children: [
                  Expanded(
                    child: Text(_dateTime == null
                        ? 'No Date Chosen!'
                        : DateFormat.yMd().format(_dateTime!)),
                  ),
                  AdaptiveFlatButton('Chose Date', _presentDatePicker)
                ]),
              ),
              ElevatedButton(
                  onPressed: _submitData,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Add transation'))
            ],
          ),
        ),
      ),
    );
  }
}
