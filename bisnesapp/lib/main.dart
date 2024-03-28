// import 'package:flutter/services.dart';

import 'dart:io';

import 'package:flutter/cupertino.dart';

import './models/transaction.dart';
import './widgets/new_transation.dart';
import './widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'widgets/chart.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Person',
      theme: ThemeData(
          primaryColor: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: const TextTheme().copyWith(
              titleMedium: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewRtansaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewTransation(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((th) {
        return th.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContect(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).primaryColorLight,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContect(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Person',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add_circled),
                  onTap: () => _startAddNewRtansaction(context),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Person',
            ),
            actions: [
              IconButton(
                  onPressed: () => _startAddNewRtansaction(context),
                  icon: const Icon(Icons.add)),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar();
    final txListWidget = SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            ..._buildLandscapeContect(
                mediaQuery, appBar as AppBar, txListWidget),
          if (!isLandscape)
            ..._buildPortraitContect(
                mediaQuery, appBar as AppBar, txListWidget),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewRtansaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
