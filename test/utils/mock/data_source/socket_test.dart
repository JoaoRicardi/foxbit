import 'dart:async';

import 'package:foxbit_hiring_test_template/src/core/data_soruce/web_socket.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/response/socket_response.dart';
import 'package:rxdart/rxdart.dart';

class TestFoxbitWebSocket implements IFoxbitSocket {
  List<String> sendedMessages = [];

  final StreamController<SocketResponse> streamController = BehaviorSubject();
  final StreamController _reciveFromServer = BehaviorSubject();

  final Map _defaultResponse = {
    'TEST_METHOD': '{"m": 1, "i": 2, "n": "Test_method", "o": "{}" }',
    'TEST_LIST_EMPTY': '{"m": 1, "i": 2, "n": "Test_method", "o": "[]" }'
  };

  Map? customResponse;

  TestFoxbitWebSocket([Map? customResponse]) {
    this.customResponse = customResponse;
    _reciveFromServer.stream.listen((event) {
      var parsedResponse = SocketResponse.fromJson(event);
      streamController.sink.add(parsedResponse);
    });
  }

  @override
  void send(String method, dynamic objectData) {
    try {
      var res = (customResponse ?? _defaultResponse)[method];
      _reciveFromServer.sink.add(res);
    }catch(err){
      throw Exception('Error');

    }
  }

  @override
  dispose() {
    _reciveFromServer.close();
    streamController.close();
  }

  @override
  Stream<SocketResponse> get stream => streamController.stream;

}