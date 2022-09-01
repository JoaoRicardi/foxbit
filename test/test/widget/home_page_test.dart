import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxbit_hiring_test_template/src/app/modules/home/home_page.dart';
import 'package:foxbit_hiring_test_template/src/app/widgets/list/currency/currency_list_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';
import 'package:foxbit_hiring_test_template/src/domain/repositories/currency/currency_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/utils.dart';

main() {
  setUpAll(() {
    TestUtils.setUpAllTests();
  });

  testWidgets('Home Page test with empty list', (WidgetTester tester) async {
    final _repository = TestUtils.instanceOf<ICurrencyRepository>();

    when(() => _repository.getAvailableCurrencies())
        .thenAnswer((invocation) => Stream.fromIterable([]));
    //[
    //               [CurrencyModel(omsId: 0, instrumentId: 1, symbol: "BTC"),CurrencyModel(omsId: 1, instrumentId: 2, symbol: "ETH")]
    //             ]

    await tester.pumpWidget(TestUtils.buildTestableWidget(widget: HomePage()));
    await tester.pump();

    expect(
        find.byKey(
          Key('home_page_scafold_key'),
        ),
        findsOneWidget);
    expect(find.text('Cotação'), findsOneWidget);
    expect(find.byType(CurrencyListItem), findsNothing);
  });

  testWidgets('Home Page test with value', (WidgetTester tester) async {
    final _repository = TestUtils.instanceOf<ICurrencyRepository>();

    when(() => _repository.getAvailableCurrencies())
        .thenAnswer((invocation) => Stream.fromIterable([
              [
                CurrencyModel(omsId: 0, instrumentId: 1, symbol: "BTC"),
                CurrencyModel(omsId: 1, instrumentId: 2, symbol: "ETH")
              ]
            ]));
    when(() =>  _repository.getCurrencyDetail(any()))
        .thenAnswer((invocation) => Stream.fromIterable([
      CurrencyDetail(
          100.0, 101.0, 102.0
      )

    ]));

    await tester.pumpWidget(TestUtils.buildTestableWidget(widget: HomePage()));
    await tester.pump();

    expect(
        find.byKey(
          Key('home_page_scafold_key'),
        ),
        findsOneWidget);
    expect(find.text('Cotação'), findsOneWidget);
    expect(find.byType(CurrencyListItem), findsNWidgets(2));

    expect(find.byKey(Key('asset_1')), findsOneWidget);
    expect(find.byKey(Key('asset_2')), findsOneWidget);

  });
}
