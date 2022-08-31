import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/data/repositories/list_currencies_repository.dart';
import 'package:foxbit_hiring_test_template/domain/usecases/list_currencies_usecase.dart';

class HomePresenter extends Presenter {

  Function heartbeatOnComplete;
  Function(dynamic) heartbeatOnError;

  final ListCurrenciesUseCase _heartbeatUseCase = ListCurrenciesUseCase(ListCurrenciesRepository());

  void sendHeartbeat(FoxbitWebSocket ws) {
    _heartbeatUseCase.execute(_HeartBeatObserver(this), ws);
  }

  @override
  void dispose() {
    _heartbeatUseCase.dispose();
  }
}

class _HeartBeatObserver implements Observer<void> {
  HomePresenter presenter;

  _HeartBeatObserver(this.presenter);

  @override
  void onNext(_) {}

  @override
  void onComplete() {
    assert(presenter.heartbeatOnComplete != null);
    presenter.heartbeatOnComplete();
  }

  @override
  void onError(dynamic e) {
    assert(presenter.heartbeatOnError != null);
    presenter.heartbeatOnError(e);
  }
}