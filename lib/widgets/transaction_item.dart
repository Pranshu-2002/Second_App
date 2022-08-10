import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.userTransaction,
    @required this.delTx,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function delTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                  child: Text(
                '₹${userTransaction.amount}',
              )),
            )),
        title: Text(
          userTransaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMd().format(userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: (() {
                  delTx(userTransaction.id);
                }),
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor),
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                onPressed: (() {
                  delTx(userTransaction.id);
                }),
                icon: const Icon(Icons.delete),
              ),
      ),
    );
  }
}
