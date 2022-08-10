import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function delTx;
  const TransactionList(this.userTransaction, this.delTx, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: userTransaction.isEmpty
            ? LayoutBuilder(
                builder: ((context, constraints) {
                  return Column(
                    children: [
                      Text(
                        'No transaction added yet!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.1,
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/image/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  );
                }),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(
                      userTransaction: userTransaction[index], delTx: delTx);
                },
                itemCount: userTransaction.length,
              ));
  }
}
