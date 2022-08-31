import 'package:foxbit_hiring_test_template/domain/entities/currency/currency.dart';

class CurrenciyListResponse{
  final int m;
  final int i;
  final String method;
  final List<CurrencyModel> itens;

  CurrenciyListResponse({this.m,this.i,this.method,this.itens});

  static CurrenciyListResponse fromJson(Map<dynamic,dynamic> json){

    List<CurrencyModel> list = [];

    if(json["o"] != null){
      var parsedList = CurrencyModel.fromJsonList(json["o"] as List);
      list.addAll(parsedList);
    }

    return CurrenciyListResponse(
        i: json["i"] as int,
        m: json["m"] as int,
        method: json["n"] as String,
        itens: list
    );
  }
}