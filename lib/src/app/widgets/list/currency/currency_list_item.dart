import 'package:flutter/material.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/controller/currency_controller.dart';
import 'package:foxbit_hiring_test_template/src/core/base/base_widget.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/core/extensions/format_extensions.dart';

class CurrencyListItem extends StatefulWidget {

  final CurrencyModel currency;

  const CurrencyListItem({
    Key? key,
    required this.currency
  }) : super(key: key);

  @override
  State<CurrencyListItem> createState() => _CurrencyListItemState();
}

class _CurrencyListItemState extends State<CurrencyListItem> with FoxbitBaseWidget{

  late CurrencyController _controller;



  String getDescriptionName(int id){
    switch(id){
      case 1:
        return "Bitcoin";
      case 2:
        return "Litecoin";
      case 4:
        return "Ethereum";
      case 6:
        return "TrueUSD";
      case 10:
        return "XRP";
      default:
        return "";
    }
  }

  @override
  void initState() {
    _controller = di.get()
      ..init(widget.currency.instrumentId);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                spreadRadius: 1,
              )
            ]
        ),
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            Flexible(
                flex: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 6, 22),
                      child: Image.asset('assets/images/${widget.currency.instrumentId}.png'),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(getDescriptionName(widget.currency.instrumentId),style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        )),
                        Text(widget.currency.symbol,style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ))
                      ],
                    )
                  ],
                )
            ),
            Flexible(
              flex: 1,
              child: StreamBuilder<CurrencyDetail>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if(snapshot.data != null) {
                      var percentValue = snapshot.data!.getPercentVariation();
                      return Text(
                        percentValue.getPercentFormat(),
                        style: TextStyle(
                          color: percentValue.getColor(),
                            fontFamily: 'Gilroy',
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.end,
                      );
                    }
                    return const CircularProgressIndicator();
                  }
              ),
            ),
            Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StreamBuilder<CurrencyDetail>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          if(snapshot.data != null) {
                            final obj = snapshot.data;
                            return Text(
                              obj!.lastValue.formatCurrency(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.end,
                            );
                          }
                          return const CircularProgressIndicator();
                        }
                    ),
                  ],
                )
            )
          ],
        )
      ),
    );
  }
}
