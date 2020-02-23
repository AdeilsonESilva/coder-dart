import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Antiga',
      value: 400.76,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo tênis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 50211.30,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de luz',
      value: 221.33,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Conta de luzzz',
      value: 100221.33,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Conta de luz',
      value: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Conta de luz t7',
      value: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Conta de luz t7',
      value: 211.30,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 't9',
    //   title: 'Conta de luz t7',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't10',
    //   title: 'Conta de luz t7',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't11',
    //   title: 'Conta de luz t7',
    //   value: 211.30,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (transaction) => transaction.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) => setState(
      () => _transactions.removeWhere((transaction) => transaction.id == id));

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: () => fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    bool _isiOS = Platform.isIOS;

    final iconList = _isiOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart = _isiOS ? CupertinoIcons.refresh : Icons.show_chart;

    final _actions = <Widget>[
      _getIconButton(
        _isiOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
      if (_isLandscape)
        _getIconButton(
          _showChart ? iconList : iconChart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
    ];

    final PreferredSizeWidget _appBar = _isiOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize: 20 * mediaQuery.textScaleFactor,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: _actions,
            ),
          )
        : AppBar(
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize: 20 * mediaQuery.textScaleFactor,
              ),
            ),
            actions: _actions);

    final avaliableHeight = mediaQuery.size.height -
        _appBar.preferredSize.height -
        mediaQuery.padding.top;

    final _bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // if (_isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Text('Exibir gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).accentColor,
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !_isLandscape)
              Container(
                height: avaliableHeight * (_isLandscape ? .8 : .25),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !_isLandscape)
              Container(
                height: avaliableHeight * (_isLandscape ? 1 : .75),
                width: double.infinity,
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return _isiOS
        ? CupertinoPageScaffold(
            child: _bodyPage,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _bodyPage,
            floatingActionButton: _isiOS
                ? null
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
