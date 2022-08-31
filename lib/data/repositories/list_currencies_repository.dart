import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/repositories/list_currencies_repository.dart';

class ListCurrenciesRepository implements IListCurrenciesRepository {
  final String _eventName = 'getInstruments';

  @override
  Future<Map> getAvailableCurrencies(FoxbitWebSocket ws) {
    ws.send(_eventName, {});


    return ws.stream.firstWhere((message) => message['n'].toString().toUpperCase() == _eventName && message['i'] == ws.lastId);
  }
  
}