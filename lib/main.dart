import 'package:flutter/material.dart';
import 'package:second_app/widgets/new_transaction.dart';
import 'package:second_app/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 'T-1',
      title: 'New Phone',
      amount: 35000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T-2',
      title: 'Household Groceries',
      amount: 4990.10,
      date: DateTime.now(),
    )
  ];
  void _addTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
      amount: txamount,
      date: DateTime.now(),
      title: txtitle,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _openFieldsToAddTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Flutter App'),
        actions: [
          IconButton(
              onPressed: () {
                _openFieldsToAddTransactions(context);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('CHART!'),
              ),
            ),
            TransactionList(_userTransaction),
            FloatingActionButton(
              onPressed: () {
                _openFieldsToAddTransactions(context);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
