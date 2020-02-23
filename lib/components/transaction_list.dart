import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: <Widget>[
                SizedBox(height: constraints.maxHeight * .05),
                Container(
                  height: constraints.maxHeight * .3,
                  child: Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .05),
                Container(
                  height: constraints.maxHeight * .6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child:
                            Text('R\$${transaction.value.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y', 'pt_BR')
                        .format(transaction.date)
                        .toUpperCase(),
                  ),
                  trailing: IconButton(
                    color: Theme.of(context).errorColor,
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: () => onRemove(transaction.id),
                  ),
                ),
              );
            },
          );
  }
}
