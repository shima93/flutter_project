import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Apps',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactios = [
    Transaction(
        id: "t1", title: 'Nikie Sneakers', amount: 69.98, date: DateTime.now()),
    Transaction(
        id: "t2",
        title: 'Weekly Groceriess',
        amount: 20.65,
        date: DateTime.now())
  ];
  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Appssß'),
      ),
      body: Center(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.pink,
                  child: Text('CHART'),
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        onChanged: (val) {
                          titleInput = val;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        onChanged: (val) {
                          amountInput = val;
                        },
                      ),
                      FlatButton(
                        child: Text('Add Transaction'),
                        textColor: Colors.purple,
                        onPressed: () {
                          print(titleInput + amountInput);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: transactios.map((tx) {
                  return Card(
                    child: Row(children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.pink[500],
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$ ${tx.amount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.pink[100]),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd').format(tx.date),
                            style: TextStyle(color: Colors.amber),
                          ),
                        ],
                      ),
                    ]),
                  );
                }).toList(),
              )
            ]),
      ),
    );
  }
}
