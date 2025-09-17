import 'package:hive/hive.dart';

part 'incomemode.g.dart';
@HiveType(typeId:0)
class Income_mode {
  @HiveField(0)
  int amount;
  @HiveField(1)
  String note;
 
  Income_mode(
    {
      required this.amount,
      required this.note,
    
      }
      );
}


@HiveType(typeId:1)
class Expense_mode {
  @HiveField(0)
  int amount;

  @HiveField(1)
  String note;

 
  Expense_mode(
    {
    required this.amount,
    required this.note,
    
     }
     );
}