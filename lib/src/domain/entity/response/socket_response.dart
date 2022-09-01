
import 'dart:convert';

import 'package:flutter/material.dart';

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