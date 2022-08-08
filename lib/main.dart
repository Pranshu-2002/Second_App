import 'package:flutter/material.dart';
import 'package:second_app/widgets/new_transaction.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import 'package:intl/intl.dart';
import './widgets/chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                // color: Colors.purple,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ).copyWith(secondary: Colors.amber),
      ),
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
    // Transaction(
    //   id: 'T-1',
    //   title: 'New Phone',
    //   amount: 35000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T-2',
    //   title: 'Household Groceries',
    //   amount: 4990.10,
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

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

  void _delTransaction(index) {
    setState(() {
      _userTransaction.removeAt(index);
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
        title: const Text(
          'Personal Expenses',
        ),
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
            Chart(_recentTransactions),
            Container(
              height: 450,
              child: _userTransaction.isEmpty
                  ? Column(
                      children: [
                        Text(
                          'No transaction added yet!',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 300,
                          child: Image.asset(
                            'assets/image/waiting.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: FittedBox(
                                      child: Text(
                                    '₹${_userTransaction[index].amount}',
                                  )),
                                )),
                            title: Text(
                              _userTransaction[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            subtitle: Text(DateFormat.yMd()
                                .add_jm()
                                .format(_userTransaction[index].date)),
                            trailing: IconButton(
                              onPressed: (() {
                                _delTransaction(index);
                              }),
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                      itemCount: _userTransaction.length,
                    ),
            ),
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
