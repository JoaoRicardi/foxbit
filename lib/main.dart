import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/app/application.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';
  
  runApp(FoxbitApp());
}