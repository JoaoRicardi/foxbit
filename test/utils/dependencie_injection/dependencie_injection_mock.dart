import 'package:foxbit_hiring_test_template/src/app/modules/home/controller/home_controller.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/controller/currency_controller.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler.dart';
import 'package:foxbit_hiring_test_template/src/core/navigation/navigation_handler_imp.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:get_it/get_it.dart';

import '../mock/repository/repository_mocks.dart';

class DIMock {
  final GetIt getIt = GetIt.I;

  registerMocks() {
    _injectDataModule();
    _injectCoreModule();
    _injectPresentationModule();
  }

  _injectPresentationModule() {
    getIt.registerLazySingleton<HomeController>(() => HomeController(getIt.get()));
    getIt.registerLazySingleton<CurrencyController>(() => CurrencyController(getIt.get()));
  }

  _injectDataModule(){
    getIt.registerLazySingleton<ICurrencyRepository>(() => CurrencyRepositoryMock());
  }

  _injectCoreModule() {
    getIt.registerLazySingleton<INavigationHandler>(
        () => NavigationHandlerImp());
  }
}
