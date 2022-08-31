import 'package:flutter/cupertino.dart';

class CurrencyDetail {
  final double lastValue;
  final double sessionOpen;
  final double sessionClose;


  CurrencyDetail(this.lastValue, this.sessionOpen, this.sessionClose);

  CurrencyDetail.empty()
      : lastValue = 0.0,
        sessionOpen = 0.0,
        sessionClose =0.0;


  static CurrencyDetail fromJson(Map json) {
    return CurrencyDetail(
        json['LastTradedPx'] ?? 0.0,
        json['SessionOpen'] ?? 0.0,
        json['SessionClose'] ?? 0.0
    );
  }


  double? getPercentVariation(){
    var divisionValues = sessionClose/sessionOpen;
    var percentValue = (1 - divisionValues)* 100;

    return double.tryParse(percentValue.toStringAsFixed(2));
  }
}