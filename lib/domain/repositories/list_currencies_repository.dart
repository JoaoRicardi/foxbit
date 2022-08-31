import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';

abstract class IListCurrenciesRepository {
  Future<Map> getAvailableCurrencies(FoxbitWebSocket ws);
}