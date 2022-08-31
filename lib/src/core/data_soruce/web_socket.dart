import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class FoxbiSocket {

  var _id = 0;
  final int _idStepSize = 2;

  final StreamController<SocketResponse> _streamController = BehaviorSubject();

  FoxbiSocket(){
    _channel.stream.listen((event) {
      var parsedResponse = SocketResponse.fromJson(event);
      _streamController.sink.add(parsedResponse);
    });
  }

  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://api.foxbit.com.br?origin=iOS:433/'),
  );

  Stream<SocketResponse> get stream => _streamController.stream;

  void send(String method, dynamic data) {
    _channel.sink.add(_prepareMessage(method, data));
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

class SocketResponse{

  final int? m;
  final int id;
  final String method;
  final dynamic data;

  SocketResponse({
    this.m = null,
    required this.id,
    required this.method,
    required this.data
  });

  SocketResponse.empty() : m = null, id = 0, method = '', data = {};

  static SocketResponse fromJson(dynamic message){
    try{
      final Map data = json.decode(message.toString()) as Map;

      if (data['o'].toString().isNotEmpty) {
        data['o'] = json.decode(data['o'].toString());
      }

      return SocketResponse(
        m: data['m'],
        id: data['i'],
        method: data['n'],
        data: data['o']
      );

    }
    catch(err){
      debugPrint('SocketResponse:fromJson error:$err');

      return SocketResponse.empty();
    }
  }

}