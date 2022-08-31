import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/app/app.dart';
import 'package:foxbit_hiring_test_template/src/core/di/di_handler_imp.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'pt_BR';

  var di = DIHandlerImp()
    ..init();

  
  runApp(FoxbitApp());
}