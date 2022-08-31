import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/widgets/home/currency_item_presenter.dart';
import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';

class CurrencyItemController extends Controller {

  final CurrencyItemPresenter presenter;
  final FoxbitWebSocket ws;
  final int id;

  CurrencyItemController(int currentId) : presenter = CurrencyItemPresenter(), ws = FoxbitWebSocket(), id = currentId{
      _getDetails(id);
  }

  void _getDetails(int id) {
    ws.connect();
    presenter.getCurrencyDetails(ws,id);
  }

  @override
  void initListeners() {
    presenter.currencyOnError = currencyOnError;
    presenter.currencyOnComplete = currencyOnComplete;
  }

  @override
  void onDisposed() {
    ws.disconnect();
    super.onDisposed();
  }

  void currencyOnComplete() {
    _scheduleNextRequest();
  }

  void currencyOnError(dynamic e) {
    (getStateKey().currentState as ScaffoldState).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 10),
        content: Text('Não foi possível enviar a mensagem: [PING]')
      )
    );

    _scheduleNextRequest();
  }
  //
  void _scheduleNextRequest() {
    // Timer(const Duration(seconds: 30), () {
    //   presenter.getCurrencyDetails(ws, id);
    // });
  }
}
