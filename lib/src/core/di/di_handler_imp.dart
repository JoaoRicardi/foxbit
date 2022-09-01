

import 'package:foxbit_hiring_test_template/src/app/modules/home/controller/home_controller.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/controller/currency_controller.dart';
import 'package:foxbit_hiring_test_template/src/core/data_soruce/web_socket.dart';
import 'package:foxbit_hiring_test_template/src/core/di/di_handler.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler_imp.dart';
import 'package:foxbit_hiring_test_template/src/data/repositories/currency/currency_repository.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:get_it/get_it.dart';

class DIHandlerImp implements IDIHandler {

  final _getIt = GetIt.I;

  @override
  init() {
    _registerCore();
    _registerData();
    _registerPresentation();
  }

  _registerCore(){
    _getIt.registerLazySingleton<INavigationHandler>(() => NavigationHandlerImp());
  }

  _registerPresentation(){
    _getIt.registerFactory<HomeController>(() => HomeController(_getIt.get()));
    _getIt.registerFactory<CurrencyController>(() => CurrencyController(_getIt.get()));

  }

  _registerData(){
    _getIt.registerFactory<ICurrencyRepository>(() => CurrencyRepository(FoxbitSocket()));
  }


  @override
  T get<T extends Object>() {
    return _getIt.get<T>();
  }
}
