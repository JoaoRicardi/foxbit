// import 'package:flutter/material.dart';
// import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
// import 'package:foxbit_hiring_test_template/app/pages/home/home_controller.dart';
// import 'package:foxbit_hiring_test_template/app/widgets/home/currency_item.dart';
// import 'package:foxbit_hiring_test_template/domain/entities/currency/available_currency/response.dart';
//
// class HomePage extends View {
//   @override
//   State<StatefulWidget> createState() => HomePageState();
// }
//
// class HomePageState extends ViewState<HomePage, HomeController> {
//   HomePageState() : super(HomeController());
//
//   @override
//   Widget get view => Scaffold(
//     key: globalKey,
//     appBar: AppBar(
//       title: const Text('Cotação',style: TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontSize: 22,
//         fontFamily: 'Gilroy'
//       ),),
//       centerTitle: false,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//     ),
//     body: ControlledWidgetBuilder<HomeController>(
//         builder: (context, controller) {
//           return StreamBuilder<Map<dynamic, dynamic>>(
//             stream: controller.ws.stream.asBroadcastStream(),
//             initialData: const {},
//             builder: (context, snapshot){
//
//               if(snapshot.data != null && (snapshot.data?.isNotEmpty ?? false)){
//
//                 final res = CurrenciyListResponse.fromJson(snapshot.data);
//
//                 return ListView.builder(
//                   itemCount: res.itens.length,
//                   itemBuilder: (context, index){
//                     final obj = res.itens[index];
//                     return CurrencyItemView(obj);
//                   }
//                 );
//
//               }
//               else{
//                 return Text(snapshot.data.toString());
//               }
//
//             }
//           );
//         }
//     ),
//   );
// }
//
//
//

