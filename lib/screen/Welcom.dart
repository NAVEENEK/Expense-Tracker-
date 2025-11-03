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
    final formkey=GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 100,
          child: AlertDialog(
            title: Text(gettiltle ? 'add income' : 'add expense'),//this decide which title to show according to our choice in two button below 

            contentPadding: EdgeInsets.all(4),
            titlePadding: EdgeInsets.all(4),

            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [Form(//A Form is a container widget that groups together one or more input fields (likeTextFormFields) and helps to =>1)Validate them together 2)Save or reset their values .
              //If you use only TextField, you can read text but can’t easily validate or manage form submission.
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller:textcontroller ,
                      decoration:InputDecoration(
                        label: Text('note'),
                       
                        border: OutlineInputBorder()
                      ) ,
                      keyboardType: TextInputType.text, 
                    ),
                    TextFormField(
                      controller: intcontroller,
                      decoration: InputDecoration(
                        label: Text('amount'),
                       
                        border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.number,
                       validator:(value){
                        if(value==null||value.trim().isEmpty){
                          return "this field is required";
                        }
                        final number=double.tryParse(value);
                        if(number==null||number==0){
                          return "enter a valid number";
                        }
                        return null;
                      },
                    )
                  ],
                )
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if(formkey.currentState!.validate()){
                  if(gettiltle){
                    var note=textcontroller.text.trim();
                    var textamount=intcontroller.text;
                    int amount=int.tryParse(textamount)??0;
                    final newincome=Income_mode(
                      amount:amount,
                      note:note,
                    );
                    incomebox.add(newincome);
                   int tempTotalIncome=total_income.get('totalincome',defaultValue: 0);
                   tempTotalIncome+=amount;
                    total_income.put('totalincome',tempTotalIncome);
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
                      int tempTotalExpense=total_expense.get('totalexpense',defaultValue: 0);
                      tempTotalExpense+=amount;
                      total_expense.put('totalexpense',tempTotalExpense);
                  }
                   int inc=total_income.get('totalincome',defaultValue: 0);
    int dic=total_expense.get('totalexpense',defaultValue: 0);
    
      int balance=inc-dic;
    
    
   total_income.put('balance',balance);


                  Navigator.of(context).pop();
                  }
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
  Future<void>cleardata(BuildContext context)async{
    final confirm=await showDialog<bool>(
      context: context, 
      builder:(context)=> AlertDialog(
        title: Text('confirm deletion'),
        content:Text('are you sure you want to delete all data ') ,
        actions: [
          TextButton(
            onPressed:()=>Navigator.pop(context,false),//Navigator.pop is a build in function which tells to exit from the current widget and go to the previous widget in the widget tree, and value and context is passed to that widget 
           child: Text("cancel")
          ),
          ElevatedButton(
           onPressed: ()=>Navigator.pop(context,true),
           child: Text('Delete')
           )

        ],

      ),
      );
      if(confirm==true){
        await Hive.box<Income_mode>('incomebox').clear();
        await Hive.box<Expense_mode>('expensebox').clear();
        await Hive.box('total_incomebox').clear();
        await Hive.box('total_expensebox').clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('all data deleted'),
            backgroundColor: Color.fromARGB(255, 158, 159, 149),
            )
          );
          setState(() {});
      }

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
                      onPressed: () => Adding(context, true),//the parameter true is passed to gettitle 
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
           
            IconButton(
             onPressed: ()=>cleardata(context),
             icon: Icon(Icons.delete_forever),
             tooltip:"delete all data"
             )
          
        ],
      ),
    );
  }
}