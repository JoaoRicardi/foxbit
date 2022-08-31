import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_details.dart';
import 'package:foxbit_hiring_test_template/src/domain/entity/currency/currency_item.dart';

abstract class ICurrencyRepository {
  Stream<List<CurrencyModel>> getAvailableCurrencies();
  Stream<CurrencyDetail> getCurrencyDetail(int id);
}