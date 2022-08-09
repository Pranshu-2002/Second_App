import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function delTx;
  const TransactionList(this.userTransaction, this.delTx, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
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
                    '₹${userTransaction[index].amount}',
                  )),
                )),
            title: Text(
              userTransaction[index].title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle:
                Text(DateFormat.yMd().format(userTransaction[index].date)),
            trailing: IconButton(
              color: Theme.of(context).errorColor,
              onPressed: (() {
                delTx(userTransaction[index].id);
              }),
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
      itemCount: userTransaction.length,
    );
  }
}
