import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  const NewTransaction(this.addTransaction, {Key key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    void submitData() {
      final enteredTitle = titleController.text;
      final enteredAmount = double.parse(amountController.text);

      if (enteredTitle.isEmpty || enteredAmount <= 0) {
        return;
      }
      widget.addTransaction(
        enteredTitle,
        enteredAmount,
      );
      Navigator.of(context).pop();
    }

    return Card(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: const Text('Add Transaction'),
              onPressed: () => submitData(),
            ),
          ],
        ),
      ),
    );
  }
}
