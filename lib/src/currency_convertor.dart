import 'package:http/http.dart' as http;
import 'package:paisa/src/entities/enums/country_code.dart';
import 'package:paisa/src/entities/enums/currency.dart';
import 'package:paisa/src/entities/models/api_response.dart';
import 'package:paisa/src/extensions/first_where_or_null.dart';
import 'package:paisa/src/extensions/search_country_code.dart';

class CurrencyConvertor {
  static final CurrencyConvertor _instance = CurrencyConvertor._internal();

  factory CurrencyConvertor() => _instance;

  CurrencyConvertor._internal();

  /// Converts the given [amount] from one currency to another.
  ///
  /// * [from] is the [Currency] to convert from.
  /// * [to] is the [Currency] enum to convert to.
  /// * [amount] is the amount to convert.
  ///
  /// [Currency] enum is used to specify the currency.\
  /// Returns the converted amount.
  ///
  /// Throws [ArgumentError] if [amount] is null or less than 0.\
  /// Example:
  /// ```dart
  /// CurrencyConvertor().convert(Currency.USD, Currency.INR, 100);
  /// ```
  static Future<double> convert({
    required Currency from,
    required Currency to,
    required double amount,
  }) async {
    if (amount <= 0) throw ArgumentError('amount cannot be less than 0');

    return _getCurrencyConversion(from.name, to.name, amount);
  }

  /// Converts the [amount] from the [from] currency to the [to] currency.\
  /// [convertFromString] accepts [String] currency codes eg: USD, INR, EUR etc
  /// Example:
  /// ```dart
  /// CurrencyConvertor.convertFromString('USD', 'INR', 100) // This will convert 100 USD to INR
  /// ```
  static Future<double> convertFromString({
    required String from,
    required String to,
    required double amount,
  }) async {
    if (amount <= 0) throw ArgumentError('amount cannot be less than 0');

    return _getCurrencyConversion(from, to, amount);
  }

  /// Return the currency conversion rate for the given [from] and [to] currencies\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rate(Currency.USD, Currency.INR);
  /// ```
  static Future<double> rate(Currency from, Currency to) async {
    return convert(from: from, to: to, amount: 1);
  }

  /// Returns the currency conversion rate for the given [from] and [to] currencies strings\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rateFromString('USD', 'INR'); // Returns the conversion rate for USD to INR
  /// ```
  static Future<double> rateFromString(String from, String to) async {
    return convertFromString(from: from, to: to, amount: 1);
  }

  /// Returns the currency conversion rate for the given [from] and [to] country codes.\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rateFromCountryCode(from:'US', to:'IN');
  /// ```
  static Future<double> rateFromCountryCode(
      {required String from, required String to}) async {
    final ccFrom = CountryCode.values.fromCode(from);
    final ccTo = CountryCode.values.fromCode(to);
    if (ccFrom == null || ccTo == null) {
      throw Exception('Country code not found');
    }

    return convert(from: ccFrom.currency, to: ccTo.currency, amount: 1);
  }

  static Future<double> _getCurrencyConversion(
      String from, String to, double amount) async {
    final uri = Uri.parse('https://open.er-api.com/v6/latest/$from');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final api = APIResponse.fromJson(response.body);

        final rate = api.rates?.entries
            .firstWhereOrNull((c) => c.key.toLowerCase() == to.toLowerCase())
            ?.value;
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
