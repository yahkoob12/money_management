import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/category/category_model.dart';
import 'package:money_management/models/transaction/transaction_model.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDb.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotfier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(5),
            itemBuilder: (ctx, index) {
              final value = newList[index];
              return Slidable(
                key: Key(value.id!),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDb.instance.deleteTransaction(value.id!);
                      },
                      icon: Icons.thumb_up,
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: value.type == CategoryType.income
                          ? Colors.black
                          : Colors.grey,
                      child: Text(
                        parseDate(value.date),
                      ),
                    ),
                    title: Text('RS ${value.amount}'),
                    subtitle: Text(value.category.name),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 0,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteDate = _date.split(' ');
    return '${_spliteDate.last}\n${_spliteDate.first}';
    //return '${date.day}\n${date.month}';
  }
}









 // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: [
                  //       Text('you want delete ?'),
                  //       Center(
                  //         child: Row(
                  //           children: [
                  //             TextButton.icon(
                  //               onPressed: () {},
                  //               label: Text(''),
                  //               icon: Icon(Icons.thumb_up_alt),
                  //             ),
                  //             TextButton.icon(
                  //               onPressed: () {},
                  //               label: Text(''),
                  //               icon: Icon(Icons.thumb_down_alt),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),