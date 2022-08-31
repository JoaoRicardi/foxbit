import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/pages/home/home_controller.dart';
import 'package:foxbit_hiring_test_template/app/widgets/home/currency_item.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends ViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController());

  @override
  Widget get view => Scaffold(
    key: globalKey,
    appBar: AppBar(
      title: const Text('Cotação',style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'Gilroy'
      ),),
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return StreamBuilder<Map<dynamic, dynamic>>(
            stream: controller.ws.stream.asBroadcastStream(),
            initialData: const {},
            builder: (context, snapshot){

              if(snapshot.data != null && (snapshot.data?.isNotEmpty ?? false)){

                final res = HomeResponseDTO.fromJson(snapshot.data);

                return ListView.builder(
                  itemCount: res.itens.length,
                  itemBuilder: (context, index){
                    final obj = res.itens[index];
                    return CurrencyItemView(obj);
                  }
                );

              }
              else{
                return Text(snapshot.data.toString());
              }

            }
          );
        }
    ),
  );
}




class HomeResponseDTO{
  final int m;
  final int i;
  final String method;
  final List<HomeResponseItemModel> itens;

  HomeResponseDTO({this.m,this.i,this.method,this.itens});

  static HomeResponseDTO fromJson(Map<dynamic,dynamic> json){

    List<HomeResponseItemModel> list = [];

    if(json["o"] != null){
      var buildedList = HomeResponseItemModel.fromJsonList(json["o"] as List);
      list.addAll(buildedList);
    }

    return HomeResponseDTO(
      i: json["i"] as int,
      m: json["m"] as int,
      method: json["n"] as String,
      itens: list
    );
  }

}

class HomeResponseItemModel{
  final int omsId;//"OMSId" -> 1
  final int instrumentId;//"InstrumentId" -> 1
  final String symbol;//"Symbol" -> "BTC/BRL"

  HomeResponseItemModel({
    this.omsId,
    this.instrumentId,
    this.symbol
  });

  static HomeResponseItemModel fromJson(Map<String, dynamic> json){
    return HomeResponseItemModel(
      omsId: json["OMSId"] != null ? json["OMSId"] as int: 0,
      instrumentId: json["InstrumentId"] != null ? json["InstrumentId"] as int: 0,
      symbol: json["Symbol"] != null ? json["Symbol"] as String: '',
    );
  }


  static List<HomeResponseItemModel> fromJsonList(List<dynamic> json){
    var list = <HomeResponseItemModel>[];

    json.forEach((element) {

      var item = HomeResponseItemModel.fromJson(element as Map<String, dynamic>);

      if([1,2,4,6,10].contains(item.instrumentId)) {
        list.add(item);
      }
    });


    list.sort((a,b) => a.instrumentId.compareTo(b.instrumentId));
    return list;
  }
}