import 'package:flutter/material.dart';

//import 'package:hive_flutter/hive_flutter.dart';
class pace extends StatelessWidget {
  const pace({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/*class Income extends StatelessWidget {
  const Income({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: "Income History",
      home: Scaffold(
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
                  valueListenable:Hive.box('incomebox').listenable(),
                   builder: (context,box,_){
                    int value=Hive.box('incomebox').get('totalincome',defaultValue: 0);
                    return Text('$value');
                   }
                  )
                ],
              ),
            )
            
          ],
        ),



      ),
    );
  }
}
Widget list(){
  return ListView.builder(
    itemCount: Hive.box('incomebox').length,
    itemBuilder: (context,index){
      var box=Hive.box('incomebox');
      final income=box.getAt(index);
      final note=Hive.box('income')
      return Card(
        color: const Color.fromARGB(193, 255, 255, 255),
        margin: EdgeInsetsGeometry.all(8),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        shadowColor: Colors.black12,
       child: Padding(
        padding: EdgeInsetsGeometry.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              
            )
          ],

        ),
       ),

      );

    }
  );

}*/