import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);



  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty 
    ? Column(
      children: <Widget> [
        Text('No hay gastos todavia', style: Theme.of(context).textTheme.titleMedium), 
        SizedBox(height: 20),
      ],
    )
   : ListView.builder(
       itemBuilder: (ctx, index){
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          color: Colors.deepPurple[50],
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(child: Text('\$${transactions[index].amount}'),),
                ),
            ),
            title: Text(
              transactions[index].title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () => deleteTx(transactions[index].id),
            ),
          ),

        );
       },
       itemCount: transactions.length,
   );
  }
}