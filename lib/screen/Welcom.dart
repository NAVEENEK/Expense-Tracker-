import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Welcom extends StatefulWidget {
  const Welcom({super.key});

  @override
  State<Welcom> createState() => _WelcomState();
}

class _WelcomState extends State<Welcom> {
  List<String> innote = [];
  List<int> inamount = [];
  List<String>exnote=[];
  List<int>examount=[];
  int total_income=0;
  int total_expense=0;
  

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
                  onSubmitted: (value) {
                    if(gettiltle){
                    innote.add(textcontroller.text.trim());
                    Hive.box('incomebox').put('innotelist', innote);
                    print(textcontroller.text);
                    textcontroller.clear();
                    }
                    else{
                      exnote.add(textcontroller.text.trim());
                      Hive.box('expensebox').put('exnotelist',exnote);
                      print(textcontroller.text);
                      textcontroller.clear();
                    }

                  },
                ),
                TextField(
                  controller: intcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'amount',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    int temp =int.tryParse(intcontroller.text) ?? 0; // convert string to int(because texteditingcontroller always store data as string). store the converted value in temp variable
                    if(gettiltle){
                    inamount.add(temp,); // the value stored in temp is transfered to amount list
                    Hive.box('incomebox').put('inamountlist',inamount); //store the value in amount list to hive box
                    total_income+=temp;
                    Hive.box('incomebox').put('totalincome',total_income);
                    }
                    else{
                      examount.add(temp);
                      Hive.box('expensebox').put('examountlist',examount);
                       total_expense+=temp;
                    Hive.box('expensebox').put('totalexpense',total_expense);
                    }
                    temp=0;
                     intcontroller.clear();
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
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
                              valueListenable:Hive.box('incomebox').listenable() ,
                              builder:(context,box,_){
                                int value=Hive.box('incomebox').get('totalincome',defaultValue: 0);
                                return Text('$value');
                              }
                              )
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
                              valueListenable: Hive.box('expensebox').listenable(),
                             builder: (context,box,_){
                              int value=Hive.box('expensebox').get('totalexpense',defaultValue:0);
                              return Text('$value');
                             }
                             )
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
        ],
      ),
    );
  }
}
