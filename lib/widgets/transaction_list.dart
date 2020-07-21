import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../models/tx.dart';

class TransactionList extends StatelessWidget {
  final List<Tx> transactions;
  final Function deleteT;
  TransactionList(this.transactions, this.deleteT);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'Nothing recorded yet!',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 8,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 6,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${transactions[index].amount}',
                          style: TextStyle(
                            color: Colors.white,

                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: TextStyle(
                      color:Theme.of(context).primaryColor,
                      fontSize:30 ,
                      fontWeight:FontWeight.bold ,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      AwesomeDialog(
                        context: ctx,
                        dialogType: DialogType.WARNING,
                        btnOk: RaisedButton(
                          color: Colors.green,
                          child: Text('Confirm'),
                          onPressed: () {
                            deleteT(transactions[index].id);
                            Navigator.of(context).pop();
                          },
                        ),
                        title: 'Warning!',
                        body: Text('Are you sure you want to delete ? '),
                        btnCancel: RaisedButton(
                          child: Text('Cancel'),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )..show();
                    },
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
