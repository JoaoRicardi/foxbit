import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/app/modules/home/controller/home_controller.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/currency_list_item.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_widget.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';

class HomePage extends StatefulWidget {

  static const String route = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with FoxbitBaseWidget {

  late HomeController _controller;

  @override
  void initState() {
    _controller = di.get()..init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
      body: StreamBuilder<List<CurrencyModel>>(
          stream: _controller.stream,
          initialData: [],
          builder: (context, snapshot){
            if(snapshot.data != null && (snapshot.data?.isNotEmpty ?? false)){
              final list = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index){
                    final currency = list[index];
                    return CurrencyListItem(
                      currency: currency,
                    );
                  }
              );

            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          }
      )
    );
  }
}
