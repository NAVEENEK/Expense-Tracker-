import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_app/incomemode.dart';
import 'package:intern_app/screen/Expense.dart';

class Welcom extends StatefulWidget {
  const Welcom({super.key});

  @override
  State<Welcom> createState() => _WelcomState();
}

class _WelcomState extends State<Welcom> {
  var incomebox=Hive.box<Income_mode>('incomebox');
  var expensebox=Hive.box<Expense_mode>('expensebox');
 var total_income=Hive.box('total_incomebox');
 var total_expense=Hive.box('total_expensebox');
 

 

  // function to add income and expense
  void Adding(BuildContext context, bool gettiltle) {
    final TextEditingController textcontroller = TextEditingController();
    final TextEditingController intcontroller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          child: AlertDialog(
            title: Text(gettiltle ? 'add income' : 'add expense'),

            contentPadding: EdgeInsets.all(4),
            titlePadding: EdgeInsets.all(4),

            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: textcontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'note',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: intcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if(gettiltle){
                    var note=textcontroller.text.trim();
                    var textamount=intcontroller.text;
                    int amount=int.tryParse(textamount)??0;
                    final newincome=Income_mode(
                      amount:amount,
                      note:note,
                    );
                    incomebox.add(newincome);
                   int temp_total_income=total_income.get('totalincome',defaultValue: 0);
                   temp_total_income+=amount;
                    total_income.put('totalincome',temp_total_income);
                  }
                  else{
                    var note=textcontroller.text.trim();
                    var textamount=intcontroller.text;
                    int amount=int.tryParse(textamount)??0;
                    final newexpense=Expense_mode(
                      amount: amount, 
                      note: note
                      );
                      expensebox.add(newexpense);
                      int temp_total_expense=total_expense.get('totalexpense',defaultValue: 0);
                      temp_total_expense+=amount;
                      total_expense.put('totalexpense',temp_total_expense);
                  }
                   int inc=total_income.get('totalincome',defaultValue: 0);
    int dic=total_expense.get('totalexpense',defaultValue: 0);
    
      int balance=inc-dic;
    
    
   total_income.put('balance',balance);


                  Navigator.of(context).pop();
                },
                

                child: Text('ok'),
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('cancel'),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 7, 241, 147),
                          boxShadow: [BoxShadow(color: Colors.black)],
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Income'),
                            ValueListenableBuilder(
                              valueListenable: total_income.listenable(),
                              builder: (context, box, _) {
                                int value = total_income.get('totalincome', defaultValue: 0);
                                return Text('$value');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () => Adding(context, true),
                      tooltip: 'add income',
                      shape: CircleBorder(),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 0, 0),
                          boxShadow: [BoxShadow(color: Colors.black)],
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Expense'),
                            ValueListenableBuilder(
                              valueListenable: total_expense.listenable(),
                              builder: (context, box, _) {
                                int value = total_expense.get('totalexpense', defaultValue: 0);
                                return Text('$value');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () => Adding(context, false),
                      tooltip: 'add expense',
                      shape: CircleBorder(),
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            color: Colors.yellow,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Text('balance'),
                ValueListenableBuilder(
                  valueListenable: total_income.listenable(),
                  builder: (context, box, _){
                    int value= total_income.get('balance',defaultValue: 0);
                    return Text('$value');
                  }
                  )

              ],
            )
          ),
        ],
      ),
    );
  }
}