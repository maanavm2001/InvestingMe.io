import 'dart:math';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

Map<String, String> apiCallHeaders = {
  "Content-Type": "application/json",
  'Accept': 'application/json',
  "Access-Control-Allow-Origin": "*"
};

final box = GetStorage();
final formatCurrency = NumberFormat.simpleCurrency();

double roundDown(double value, int precision) {
  final isNegative = value.isNegative;
  final mod = pow(10.0, precision);
  final roundDown = (((value.abs() * mod).floor()) / mod);
  return isNegative ? -roundDown : roundDown;
}

String get id => box.read('id');
String get jwt => box.read('jwt');

late Map<String, dynamic> user = {'startDate': '20220228'};
