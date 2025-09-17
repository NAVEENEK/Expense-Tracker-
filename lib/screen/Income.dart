import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:intern_app/incomemode.dart';


class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  var incomebox=Hive.box<Income_mode>('incomebox');
  var total_income=Hive.box('total_incomebox');

Widget list(){
  return Expanded(
    child: ValueListenableBuilder(
      valueListenable: incomebox.listenable(),
      builder: (context, box, _){
        if(incomebox.isEmpty){
          return const Center(
            child: Text('No Transaction Yet'),
          );
        }
        else{
          
          return ListView.builder(
            itemCount: incomebox.length,
            itemBuilder: (context,index){
              final trans=incomebox.getAt(index);
              if(trans==null)return SizedBox.shrink();
              return ListTile(
                leading: Text(
                  '${index+1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
                title: Text('₹${trans!.amount}'),
                subtitle: Text(trans!.note),
          
              );
            }
            );
        }
      }
    ),
  );

}

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
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
                  Text('Income'),
                  ValueListenableBuilder(
                  valueListenable:total_income.listenable(),
                   builder: (context,box,_){
                    int value=total_income.get('totalincome',defaultValue: 0);
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
