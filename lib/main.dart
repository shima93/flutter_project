import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() => {
      // WidgetsFlutterBinding.ensureInitialized(),
      // SystemChrome.setPreferredOrientations(
      //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
      runApp(MyApp())
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red[50],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 22,
                    fontWeight: FontWeight.normal),
                // button: TextStyle(color: Colors.pink[50])
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Open sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: "t1", title: 'Nikie Sneakers', amount: 69.98, date: DateTime.now()),
    // Transaction(
    //     id: "t2",
    //     title: 'Weekly Groceriiiess',
    //     amount: 20.65,
    //     date: DateTime.now())
  ];
  bool _showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    // TODO: implement didChangeAppLifecycleState
    // super.didChangeAppLifecycleState(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  Widget _buildLandscapeContent() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text('Show Chart'),
      Switch.adaptive(
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          })
    ]);
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, txListWidget) {
    return [
      Container(
          height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              .3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title:
          Text('Personal Expenses', style: TextStyle(fontFamily: 'open sans')),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewBottomSheet(context),
        )
      ],
    );
    final txListWidget = Container(
        height:
            (MediaQuery.of(context).size.height - appBar.preferredSize.height) *
                0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandscape) _buildLandscapeContent(),
              if (!isLandscape)
                ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
              if (isLandscape)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            .7,
                        child: Chart(_recentTransactions))
                    : txListWidget,
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewBottomSheet(context),
            ),
    );
  }
}
