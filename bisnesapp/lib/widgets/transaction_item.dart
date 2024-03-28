import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.userTransaction,
    required this.deleteTx,
  });

  final Transaction userTransaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor = Colors.white;

  @override
  void initState() {
    const availableColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text(
                  '\$${widget.userTransaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            )),
        title: Text(
          widget.userTransaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat.yMd().format(widget.userTransaction.date),
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 300
            ? TextButton.icon(
                icon: const Icon(Icons.folder_delete_rounded),
                onPressed: () {
                  widget.deleteTx(widget.userTransaction.id);
                },
                label: const Text('Delete'),
              )
            : IconButton(
                icon: const Icon(Icons.delete_sweep),
                onPressed: () => widget.deleteTx(widget.userTransaction.id),
              ),
      ),
    );
  }
}
