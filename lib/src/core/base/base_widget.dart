import 'package:foxbit_hiring_test_template/src/core/di/di_handler.dart';
import 'package:foxbit_hiring_test_template/src/core/di/di_handler_imp.dart';
import 'package:foxbit_hiring_test_template/src/core/values/constants.dart';

class FoxbitBaseWidget {
  final IDIHandler di = DIHandlerImp();
  final FoxbitConstants constants = FoxbitConstants();
}