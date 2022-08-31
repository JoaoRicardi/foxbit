

import 'package:foxbit_hiring_test_template/src/core/di/di_handler.dart';
import 'package:get_it/get_it.dart';

class DIHandlerImp implements IDIHandler {

  final _getIt = GetIt.I;

  @override
  init() {

  }


  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
