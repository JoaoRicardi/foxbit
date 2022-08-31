import 'package:foxbit_hiring_test_template/data/helpers/websocket.dart';
import 'package:foxbit_hiring_test_template/domain/repositories/currency_repository.dart';

class CurrencyRepository implements ICurrencyRepository {
  
  final String _eventName = 'SubscribeLevel1';

  @override
  Future<Map> getCurrencyDetail(FoxbitWebSocket ws, int id) {
    ws.send(_eventName, {
      "InstrumentId": id
    });

    return ws.stream.firstWhere((message) => message['n'].toString().toUpperCase() == _eventName && message['i'] == ws.lastId);
  }
}