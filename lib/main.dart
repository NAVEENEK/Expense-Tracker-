import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intern_app/incomemode.dart';
import 'package:intern_app/screen/expense.dart';
import 'package:intern_app/screen/income.dart';
import 'package:intern_app/screen/welcom.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(IncomemodeAdapter());
  await Hive.openBox<Income_mode>('incomebox');
  Hive.registerAdapter(ExpensemodeAdapter());
  await Hive.openBox<Expense_mode>('expensebox');
  await Hive.openBox('total_incomebox');
  await Hive.openBox('total_expensebox');
  runApp(MaterialApp(
     title: 'Expense Tracker',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 91, 194, 253),
        scaffoldBackgroundColor: Colors.white,
      ),
    debugShowCheckedModeBanner: false,
    home:Main())); 
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
 
 /* Future<void>cleardata(BuildContext context)async{
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

  }*/
   int _selectedIndex = 0;
  
  static List<Widget> page = [Welcom(), Income(), Expense()];

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: page[_selectedIndex],//this display the selected page 
        appBar: AppBar(
          title: Text('Expence Tracker'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          /*actions: [
            IconButton(
             onPressed: ()=>cleardata(context),
             icon: Icon(Icons.delete_forever),
             tooltip:"delete all data"
             )
          ],*/
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,//decides which tab looks active (highlighted).
          onTap: (int index) {//BottomNavigationBar can automatically undertand which option is selected and assing that value to index 
            setState(() {
              _selectedIndex = index;//value of setstate is updated and rebuilded 
            });
          },
          selectedItemColor: const Color.fromARGB(255, 176, 146, 54),
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
               label: 'Home'
               ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Income log',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_down),
              label: 'Expense log',
            ),
          ],
        ),
      );
  }
}