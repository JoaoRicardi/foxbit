import 'dart:async';

import 'package:foxbit_hiring_test_template/src/app/modules/home/controller/home_controller.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_controller.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_stream.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyController implements BaseController, BaseStream<CurrencyDetail> {
  final ICurrencyRepository _currencyRepository;

  final StreamController<CurrencyDetail> _streamController = BehaviorSubject();

  late StreamSubscription _subscription;

  CurrencyController(this._currencyRepository);

  @override
  dispose() {
    _subscription.cancel();
    _streamController.done;
    _currencyRepository.dispose();
  }

  @override
  init([dynamic params]) {
    var res = _currencyRepository.getCurrencyDetail(params);
    _subscription = res.listen(null);
    _subscription.onData((data) {
      _streamController.sink.add(data);
    });

    _subscription.onError((error, stackTrace) {});
    _currencyRepository.getCurrencyDetail(params);

  }


  @override
  Stream<CurrencyDetail> get stream => _streamController.stream.asBroadcastStream();
}
