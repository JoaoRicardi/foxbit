// class CurrencyModel{
//   final int omsId;//"OMSId" -> 1
//   final int instrumentId;//"InstrumentId" -> 1
//   final String symbol;//"Symbol" -> "BTC/BRL"
//
//   CurrencyModel({
//     this.omsId,
//     this.instrumentId,
//     this.symbol
//   });
//
//   static CurrencyModel fromJson(Map<String, dynamic> json){
//     return CurrencyModel(
//       omsId: json["OMSId"] != null ? json["OMSId"] as int: 0,
//       instrumentId: json["InstrumentId"] != null ? json["InstrumentId"] as int: 0,
//       symbol: json["Symbol"] != null ? json["Symbol"] as String: '',
//     );
//   }
//
//
//   static List<CurrencyModel> fromJsonList(List<dynamic> json){
//     var list = <CurrencyModel>[];
//
//     json.forEach((element) {
//
//       var item = CurrencyModel.fromJson(element as Map<String, dynamic>);
//
//       //filtro para mostrar apenas as do layout
//       if([1,2,4,6,10].contains(item.instrumentId)) {
//         list.add(item);
//       }
//     });
//
//
//     list.sort((a,b) => a.instrumentId.compareTo(b.instrumentId));
//     return list;
//   }
// }