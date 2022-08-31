import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:foxbit_hiring_test_template/src/core/data_soruce/web_socket.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:rxdart/rxdart.dart';

class CurrencyRepository implements ICurrencyRepository {
  final FoxbiSocket socket;

  CurrencyRepository(this.socket);

  @override
  Stream<List<CurrencyModel>> getAvailableCurrencies() {
    final StreamController<List<CurrencyModel>> availableCurrenciesController =
        BehaviorSubject();
    try {
      socket.send("getInstruments", {});
      socket.stream.listen((SocketResponse event) {
        var obj = CurrencyModel.fromJsonList(event.data as List);

        availableCurrenciesController.sink.add(obj);
      });
    } catch (err) {
      debugPrint('CurrencyRepository:getAvailableCurrencies err$err');

      availableCurrenciesController.addError(err);
    }

    return availableCurrenciesController.stream;
  }

  @override
  Stream<CurrencyDetail> getCurrencyDetail(int id) {
    final StreamController<CurrencyDetail> availableCurrenciesController =
    BehaviorSubject();
    try {
      socket.send("SubscribeLevel1",  {
        "InstrumentId": id
      });
      socket.stream.listen((SocketResponse event) {
        var obj = CurrencyDetail.fromJson(event.data);

        availableCurrenciesController.sink.add(obj);
      });
    } catch (err) {
      debugPrint('CurrencyRepository:getCurrencyDetail err$err');

      availableCurrenciesController.addError(err);
    }

    return availableCurrenciesController.stream;
  }
}
