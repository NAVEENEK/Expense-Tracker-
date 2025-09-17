import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_app/incomemode.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
var expensebox=Hive.box<Expense_mode>('expensebox');
var total_expense=Hive.box('total_expensebox');


Widget list(){
return Expanded(
  child: ValueListenableBuilder(
    valueListenable: expensebox.listenable(), 
    builder: (context,box,_){
      if(expensebox.isEmpty){
        return Center(child: Text('No Transaction Yet'),);
      }
      else{
        return ListView.builder(
          itemCount: expensebox.length,
          itemBuilder: (context,index){
            final trans=expensebox.getAt(index);
            if(trans==null)return SizedBox.shrink();
            return ListTile(
              leading: Text(
                '${index+1}',
                 style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                title: Text('${trans!.amount}'),
                subtitle: Text(trans!.note),
            );
          },
          );
      }
    }
    )
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(15),
              decoration:BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  )
                ]
              ),
              child: Column(
                children: [
                  Text('Expense'),
                  ValueListenableBuilder(
                  valueListenable:total_expense.listenable(),
                   builder: (context,box,_){
                    int value=total_expense.get('totalexpense',defaultValue: 0);
                    return Text('$value');
                   }
                  ),
          
                ],
              ),
            ),
            list()
        ],
      ),
    );
  }
}