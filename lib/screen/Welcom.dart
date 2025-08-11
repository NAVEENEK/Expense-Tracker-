import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Welcom extends StatefulWidget {
  const Welcom({super.key});

  @override
  State<Welcom> createState() => _WelcomState();
}

class _WelcomState extends State<Welcom> {
  List<String> note = [];
  List<int> amount = [];

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
                    note.add(textcontroller.text.trim());
                    Hive.box('strbox').put('notelist', note);
                    print(textcontroller.text);
                    print(textcontroller.text);
                    textcontroller.clear();
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
                    int temp =
                        int.tryParse(intcontroller.text) ??
                        0; // convert string to int(because texteditingcontroller always store data as string). store the converted value in temp variable
                    amount.add(
                      temp,
                    ); // the value stored in temp is transfered to amount list
                    Hive.box('intbox').put(
                      'amountlist',
                      amount,
                    ); //store the value in amount list to hive box
                    print(temp);
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
                          color: Colors.red,
                          boxShadow: [BoxShadow(color: Colors.black)],
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Expence')],
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () => Adding(context, true),
                      backgroundColor: const Color.fromARGB(255, 251, 253, 254),
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
                          color: Colors.greenAccent,
                          boxShadow: [BoxShadow(color: Colors.black)],
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Income')],
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () => Adding(context, false),
                      backgroundColor: const Color.fromARGB(255, 244, 243, 242),
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
