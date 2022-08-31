import 'dart:async';

import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeController implements BaseController, BaseStream<List<CurrencyModel>> {
  final ICurrencyRepository _currencyRepository;

  final StreamController<List<CurrencyModel>> _streamController =
      BehaviorSubject();

  StreamSubscription? _subscription;

  HomeController(this._currencyRepository);

  @override
  dispose() {
    _subscription?.cancel();
    _streamController.done;
  }

  @override
  init([dynamic params]) {
    _subscription = _currencyRepository.getAvailableCurrencies().listen(null);

    _subscription?.onData((data) {
      _streamController.sink.add(data);
    });

    _subscription?.onError((error, stackTrace) {

    });

  }

  @override
  Stream<List<CurrencyModel>> get stream => _streamController.stream.asBroadcastStream();
}

abstract class BaseStream<T> {
  Stream<T> get stream;
}

abstract class BaseController {
  init([dynamic params]);

  dispose();
}
