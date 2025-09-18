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
  //0=input order, 1=increasing amount order 
int sort_option=0;
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
          //convert hive box into a list
          List<Income_mode>items=incomebox.values.toList().cast<Income_mode>();
          //apply sorting 
          if(sort_option==1){
            items.sort((a,b)=>a.amount.compareTo(b.amount));//increasing
          }
          else if(sort_option==2){
            items.sort((a,b)=>b.amount.compareTo(a.amount));//decreasing
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              final trans=items[index];
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
            //sorting button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               DropdownButton<int>(
                value: sort_option,//value tells flutter which option is current selected 
                items: const[
                  DropdownMenuItem(
                    value: 0,
                    child:Text('input order'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('increasing'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('decreasing'),
                    ),
                ],
                onChanged: (value){
                  if(value!=null){
                    setState(() {
                      sort_option=value;
                    });
                  }
                }
                )
              ],
            ),

            list()
          ],
        ),
    );
  }
}
