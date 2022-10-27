import 'package:currency_dart/src/entities/enums/currency.dart';
import 'package:currency_dart/src/entities/models/api_response.dart';
import 'package:currency_dart/src/extensions/first_where_or_null.dart';
import 'package:http/http.dart' as http;

class CurrencyConvertor {
  static final CurrencyConvertor _instance = CurrencyConvertor._internal();

  factory CurrencyConvertor() => _instance;

  CurrencyConvertor._internal();

  static Future<double> convert({required Currency from, required Currency to, required double amount}) async {
    assert(from != to, 'From and To currencies cannot be the same');
    assert(amount > 0, 'Amount must be greater than 0');

    // Since enum cannot be try we substitute lira with try string
    final uri = Uri.parse('https://open.er-api.com/v6/latest/${from == Currency.lira ? 'try' : from.name}');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final api = APIResponse.fromJson(response.body);
        final toName = to == Currency.lira ? 'try' : to.name;

        final double? rate =
            api.rates?.entries.firstWhereOrNull((c) => c.key.toLowerCase() == toName)?.value.toDouble();
        if (rate == null) {
          throw Exception('Currency not found');
        }

        return amount * rate;
      } else {
        throw Exception('Error while converting currency');
      }
    } catch (e) {
      throw Exception('Error while converting currency');
    }
  }

  static Future<double> rate(Currency from, Currency to) async {
    return convert(from: from, to: to, amount: 1);
  }
}
