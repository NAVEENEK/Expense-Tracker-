import 'package:hive/hive.dart';

part 'incomemode.g.dart';
@HiveType(typeId:0)
class Incomemode {
  @HiveField(0)
  double amount;
  @HiveField(1)
  String note;
  Incomemode({required this.amount,required this.note});
}