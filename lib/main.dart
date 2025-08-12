import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intern_app/screen/expense.dart';
import 'package:intern_app/screen/income.dart';
import 'package:intern_app/screen/welcom.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('incomebox');
  await Hive.openBox('expensebox');
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  
  static List<Widget> page = [Welcom(), Income(), Expense()];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 91, 194, 253),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: page[_selectedIndex],
        appBar: AppBar(
          title: Text('Expence Tracker'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
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
      ),
    );
  }
}
