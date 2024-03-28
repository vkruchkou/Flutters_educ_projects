import '../models/transaction.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;
  const TransactionList(this._userTransactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions add',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          )
        : ListView(
            children: _userTransactions
                .map((tx) => TransactionItem(
                      userTransaction: tx,
                      deleteTx: deleteTx,
                      key: ValueKey(tx.id),
                    ))
                .toList(),
          );
  }
}

// ListView.builder(
//             itemBuilder: (ctx, index) {
//               return TransactionItem(
//                 userTransaction: _userTransactions[index],
//                 deleteTx: deleteTx,
//                 key: ValueKey(_userTransactions[index].id),
//               );
//             },
//             itemCount: _userTransactions.length,
//           );




// return Card(
//                   child: Row(
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.all(10),
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                             color: Colors.purple,
//                             width: 2,
//                           )),
//                           child: Text(
//                             '\$${_userTransactions[index].amount.toStringAsFixed(2)}',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                                 color: Theme.of(context).primaryColor),
//                           )),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             _userTransactions[index].title,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           Text(
//                             DateFormat.yMd()
//                                 .format(_userTransactions[index].date),
//                             style: const TextStyle(color: Colors.grey),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );