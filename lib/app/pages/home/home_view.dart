import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:foxbit_hiring_test_template/app/pages/home/home_controller.dart';

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
      title: const Text('Home Screen'),
    ),
    body: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return StreamBuilder<Map<dynamic, dynamic>>(
            stream: controller.ws.stream.asBroadcastStream(),
            initialData: const {},
            builder: (context, snapshot){

              if(snapshot.data.isNotEmpty){
                print(snapshot.data);

                var res = HomeResponseDTO.fromJson(snapshot.data);

                return ListView.builder(
                  itemCount: res.itens.length,
                  itemBuilder: (context, index){
                    var obj = res.itens[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        child: Center(
                          child: Text(obj.symbol),
                        ),
                      ),
                    );
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

//
class HomeResponseDTO{
  final int m;
  final int i;
  final String method;
  final List<HomeResponseItemModel> itens;

  HomeResponseDTO({this.m, this.i, this.method, this.itens});

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
      list.add(HomeResponseItemModel.fromJson(element as Map<String, dynamic>));
    });

    return list;
  }
  // "Product1" -> 1
  // "Product1Symbol" -> "BTC"
  // "Product2" -> 2
  // "Product2Symbol" -> "BRL"
  // "InstrumentType" -> "Standard"
  // "VenueInstrumentId" -> 1
  // "VenueId" -> 1
  // "SortIndex" -> 0
  // "SessionStatus" -> "Running"
  // "PreviousSessionStatus" -> "Paused"
  // "SessionStatusDateTime" -> "2020-07-11T01:27:02.851Z"
  // "SelfTradePrevention" -> true
  // "QuantityIncrement" -> 1e-8
  // "PriceIncrement" -> 0.01
  // "MinimumQuantity" -> 1e-8
  // "MinimumPrice" -> 0.01
  // "VenueSymbol" -> "BTC/BRL"
  // "IsDisable" -> false
  // "MasterDataId" -> 0
  // "PriceCollarThreshold" -> 0
  // "PriceCollarPercent" -> 0
  // "PriceCollarEnabled" -> false
  // "PriceFloorLimit" -> 0
  // "PriceFloorLimitEnabled" -> false
  // "PriceCeilingLimit" -> 0
  // "PriceCeilingLimitEnabled" -> false
  // "CreateWithMarketRunning" -> true
  // "AllowOnlyMarketMakerCounterParty" -> false
}