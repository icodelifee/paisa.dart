import 'package:http/http.dart' as http;
import 'package:paisa_dart/src/entities/enums/country_code.dart';
import 'package:paisa_dart/src/entities/enums/currency.dart';
import 'package:paisa_dart/src/entities/models/api_response.dart';
import 'package:paisa_dart/src/extensions/first_where_or_null.dart';
import 'package:paisa_dart/src/extensions/search_country_code.dart';

class CurrencyConvertor {
  static final CurrencyConvertor _instance = CurrencyConvertor._internal();

  factory CurrencyConvertor() => _instance;

  CurrencyConvertor._internal();

  static Future<double> convert({required Currency from, required Currency to, required double amount}) async {
    assert(from != to, 'From and To currencies cannot be the same');
    assert(amount > 0, 'Amount must be greater than 0');

    return _getCurrencyConversion(from.name, to.name, amount);
  }

  static Future<double> convertFromString({required String from, required String to, required double amount}) async {
    assert(from.toLowerCase() != to.toLowerCase(), 'From and To currencies cannot be the same');
    assert(amount > 0, 'Amount must be greater than 0');

    return _getCurrencyConversion(from, to, amount);
  }

  static Future<double> rate(Currency from, Currency to) async {
    return convert(from: from, to: to, amount: 1);
  }

  static Future<double> rateFromString(String from, String to) async {
    return convertFromString(from: from, to: to, amount: 1);
  }

  static Future rateFromCountryCode({required String from, required String to}) async {
    final ccFrom = CountryCode.values.fromCode(from);
    final ccTo = CountryCode.values.fromCode(to);
    if (ccFrom == null || ccTo == null) {
      throw Exception('Country code not found');
    }

    return convert(from: ccFrom.currency, to: ccTo.currency, amount: 1);
  }

  static Future<double> _getCurrencyConversion(String from, String to, double amount) async {
    final uri = Uri.parse('https://open.er-api.com/v6/latest/$from');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final api = APIResponse.fromJson(response.body);

        final rate = api.rates?.entries.firstWhereOrNull((c) => c.key.toLowerCase() == to.toLowerCase())?.value;
        if (rate == null) {
          throw Exception('Currency not found');
        }

        return amount * rate.toDouble();
      } else {
        throw Exception('Error while converting currency');
      }
    } catch (e) {
      throw Exception('Error while converting currency');
    }
  }
}
