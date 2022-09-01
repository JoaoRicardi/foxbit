import 'dart:async';
import 'dart:convert';
import 'package:foxbit_hiring_test_template/src/domain/entity/response/socket_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FoxbitSocket implements IFoxbitSocket{

  var _id = 0;
  final int _idStepSize = 2;

  final StreamController<SocketResponse> _streamController = BehaviorSubject();

  FoxbitSocket(){

    channel.stream.listen((event) {
      print('event incoming');
      print(event.toString());
      var parsedResponse = SocketResponse.fromJson(event);
      _streamController.sink.add(parsedResponse);
    });
  }

  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('wss://api.foxbit.com.br?origin=iOS:433/'),
  );

  @override
  Stream<SocketResponse> get stream => _streamController.stream;

  @override
  void send(String method, dynamic data) {
    channel.sink.add(_prepareMessage(method, data));
  }

  @override
  dispose(){
    channel.sink.close();
  }


  String _prepareMessage(String method, dynamic objectData) {
    final Map data = {
      "m": 0,
      "i": _id,
      "n": method,
      "o": json.encode(objectData)
    };

    _id += _idStepSize;

    return json.encode(data);
  }
}

abstract class IFoxbitSocket {
  dispose();
  send(String method, dynamic data);
  Stream<SocketResponse> get stream;
}