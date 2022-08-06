import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  const TransactionList(this.userTransaction, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '₹${userTransaction[index].amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userTransaction[index].title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(
                      DateFormat.yMd()
                          .add_jm()
                          .format(userTransaction[index].date),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: userTransaction.length,
      ),
    );
  }
}
