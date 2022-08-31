// import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
// import 'package:foxbit_hiring_test_template/data/repositories/currency_repository.dart';
// import 'package:foxbit_hiring_test_template/domain/usecases/currency_usecase.dart';
//
// class CurrencyItemPresenter extends Presenter {
//
//   final CurrencyUseCase _currencyUseCase = CurrencyUseCase(CurrencyRepository());
//
//   @override
//   void dispose() {
//     _currencyUseCase.dispose();
//   }
//
//   void getCurrencyDetails(FoxbitWebSocket ws, int id) {
//     _currencyUseCase.execute(_CurrencyItemObserver(this), CustomParams(id, ws));
//   }
//
//   Function currencyOnComplete;
//   Function(dynamic) currencyOnError;
//
//
// }
//
// class _CurrencyItemObserver implements Observer<void> {
//
//   CurrencyItemPresenter presenter;
//
//   _CurrencyItemObserver(this.presenter);
//
//   @override
//   void onNext(_) {}
//
//   @override
//   void onComplete() {
//     assert(presenter.currencyOnComplete != null);
//     presenter.currencyOnComplete();
//   }
//
//   @override
//   void onError(dynamic e) {
//     assert(presenter.currencyOnError != null);
//     presenter.currencyOnError(e);
//   }
// }