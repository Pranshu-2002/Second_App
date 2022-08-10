import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/list_transactions.dart';

void main() {
  runApp(const MyApp());
}

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
              button: const TextStyle(color: Colors.white),
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
  final List<Transaction> _userTransaction = [];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txtitle, double txamount, DateTime selectDate) {
    final newTx = Transaction(
      amount: txamount,
      date: selectDate,
      title: txtitle,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _delTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _openFieldsToAddTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget showList) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Show Chart'),
        Switch(
          activeColor: Theme.of(context).colorScheme.secondary,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        )
      ]),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : showList,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget showList) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      showList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final showIconButton = IconButton(
        onPressed: () {
          _openFieldsToAddTransactions(context);
        },
        icon: const Icon(Icons.add));
    final appBar = AppBar(
      title: const Text(
        'Personal Expenses',
      ),
      actions: [
        isLandscape
            ? (mediaQuery.size.height > 450 ? showIconButton : Container())
            : showIconButton,
      ],
    );

    final showFloatingButton = FloatingActionButton(
      onPressed: () {
        _openFieldsToAddTransactions(context);
      },
      child: const Icon(Icons.add),
    );
    final showList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _delTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, showList),
            if (!isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, showList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLandscape
          ? (mediaQuery.size.height > 450 ? showFloatingButton : Container())
          : showFloatingButton,
    );
  }
}
