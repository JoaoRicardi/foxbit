// import 'package:flutter/material.dart';
// import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'package:foxbit_hiring_test_template/app/pages/home/home_view.dart';
// import 'package:foxbit_hiring_test_template/app/widgets/home/currency_item_controller.dart';
// import 'package:foxbit_hiring_test_template/domain/entities/currency/currency.dart';
// import 'package:intl/intl.dart';
//
// class CurrencyItemView extends View{
//
//   final CurrencyModel item;
//
//   CurrencyItemView(this.item);
//
//   @override
//   State<StatefulWidget> createState() => CurrencyItemViewState(item.instrumentId);
// }
//
// class CurrencyItemViewState extends ViewState<CurrencyItemView, CurrencyItemController> {
//
//   CurrencyItemViewState(int currentId) : super(CurrencyItemController(currentId));
//
//   final format = NumberFormat.simpleCurrency();
//   final percent = NumberFormat.percentPattern("pt_BR");
//
//   @override
//   Widget get view => Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 12,
//               spreadRadius: 1,
//             )
//           ]
//       ),
//       width: double.infinity,
//       height: 80,
//       child: ControlledWidgetBuilder<CurrencyItemController>(
//         builder: (context, controller) {
//           return Row(
//             children: [
//               Flexible(
//                 flex: 2,
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 22, 6, 22),
//                       child: Image.asset('assets/images/${widget.item.instrumentId}.png'),
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(getDescriptionName(widget.item.instrumentId),style: TextStyle(
//                           fontFamily: 'Gilroy',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold
//                         )),
//                         Text(widget.item.symbol,style: TextStyle(
//                             fontFamily: 'Gilroy',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400
//                         ))
//                       ],
//                     )
//                   ],
//                 )
//               ),
//               Flexible(
//                 flex: 1,
//                 child: StreamBuilder(
//                     stream: controller.ws.stream.asBroadcastStream(),
//                     initialData: {},
//                     builder: (context, snapshot) {
//                       if(snapshot.data != null) {
//                         if (snapshot.data is Map &&
//                             (snapshot.data as Map).isNotEmpty) {
//                           final obj = DetailsReturn.fromJson(
//                               snapshot.data as Map);
//                           return Text(
//                             percent.format(obj.details.pxChangeDaily),
//                             style: TextStyle(
//                               color: getColor(obj.details.pxChangeDaily),
//                               fontFamily: 'Gilroy',
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold
//                             ),
//                             textAlign: TextAlign.end,
//                           );
//                         }
//                       }
//                       return const Text('{}');
//                     }
//                 ),
//               ),
//               Flexible(
//                 flex: 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     StreamBuilder(
//                         stream: controller.ws.stream.asBroadcastStream(),
//                         initialData: {},
//                         builder: (context, snapshot) {
//                           if(snapshot.data != null) {
//                             if (snapshot.data is Map &&
//                                 (snapshot.data as Map).isNotEmpty) {
//                               final obj = DetailsReturn.fromJson(
//                                   snapshot.data as Map);
//                               return Text(
//                                 format.format(obj.details.lastValue),
//                                 style: TextStyle(
//                                     fontFamily: 'Gilroy',
//                                     fontSize: 22,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                                 textAlign: TextAlign.end,
//                               );
//                             }
//                           }
//                           return const Text('{}');
//                         }
//                     ),
//                   ],
//                 )
//               )
//             ],
//           );
//         }
//       ),
//     ),
//   );
//
//   Color getColor(double value){
//     if(value < 0){
//       return Colors.red;
//     }
//     else{
//       return Colors.green;
//     }
//   }
//
//
//   String getDescriptionName(int id){
//     switch(id){
//       case 1:
//         return "Bitcoin";
//       case 2:
//         return "Litecoin";
//       case 4:
//         return "Ethereum";
//       case 6:
//         return "TrueUSD";
//       case 10:
//         return "XRP";
//       default:
//         return "";
//     }
//   }
// }
//
// class DetailsReturn{
//   final int m;
//   final int i;
//   final String eventName;
//   final CurrencyDetail details;
//
//   DetailsReturn(this.m, this.i, this.eventName, this.details);
//
//   static DetailsReturn fromJson(Map json){
//     return DetailsReturn(
//         json["m"] as int,
//         json["i"] as int,
//         json["n"] as String,
//         CurrencyDetail.fromJson(json["o"] as Map)
//     );
//   }
// }
//
// class CurrencyDetail {
//   final double lastValue;
//   final double pxChangeDaily;
//
//   CurrencyDetail(this.lastValue, this.pxChangeDaily);
//
//   static CurrencyDetail fromJson(Map<dynamic, dynamic> json){
//     double lastValue = 0.0;
//     double pxChange = 0.0;
//
//     if(json['LastTradedPx'] != null && json['LastTradedPx'] is double){
//       lastValue = json['LastTradedPx'] as double;
//     }
//     if(json['CurrentDayPxChange'] != null && json['CurrentDayPxChange'] is double){
//       pxChange = json['CurrentDayPxChange'] as double;
//     }
//
//     return CurrencyDetail(lastValue, pxChange);
//   }
//
//
//   // "OMSId" -> 1
//   // "InstrumentId" -> 2
//   // "BestOffer" -> 269.8634
//   // "BestBid" -> 260.2039
//
//   // "LastTradedQty" -> 0.48520746
//   // "LastTradeTime" -> 1661881752
//   // "SessionOpen" -> 282.4932
//   // "SessionHigh" -> 283.8345
//   // "SessionLow" -> 262.4922
//   // "SessionClose" -> 266.1
//   // "Volume" -> 0.48520746
//   // "CurrentDayVolume" -> 81.5361
//   // "CurrentDayNumTrades" -> 41
//
//   // "Rolling24HrVolume" -> 103.2695
//   // "Rolling24NumTrades" -> 70
//   // "Rolling24HrPxChange" -> -5.803
// }