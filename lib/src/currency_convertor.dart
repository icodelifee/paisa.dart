import 'package:http/http.dart' as http;
import 'package:paisa/src/entities/enums/country_code.dart';
import 'package:paisa/src/entities/enums/currency.dart';
import 'package:paisa/src/entities/models/api_response.dart';
import 'package:paisa/src/entities/models/paisa.dart';
import 'package:paisa/src/extensions/first_where_or_null.dart';
import 'package:paisa/src/extensions/search_country_code.dart';

class CurrencyConvertor {
  static final CurrencyConvertor _instance = CurrencyConvertor._internal();

  factory CurrencyConvertor() => _instance;

  CurrencyConvertor._internal();

  /// Converts the given [amount] from one currency to another.\
  /// Returns [Paisa] object with the converted amount.
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
  static Future<Paisa> convert({
    required Currency from,
    required Currency to,
    required double amount,
  }) async {
    try {
      final rate = await _getConversionRate(from.name, to.name, amount);

      return Paisa(amount: amount, rate: rate, from: from, to: to);
    } catch (e) {
      rethrow;
    }
  }

  /// Converts the [amount] from the [from] currency to the [to] currency.\
  /// [convertFromString] accepts [String] currency codes eg: USD, INR, EUR etc
  /// Example:
  /// ```dart
  /// CurrencyConvertor.convertFromString('USD', 'INR', 100) // This will convert 100 USD to INR
  /// ```
  static Future<Paisa> convertFromString({
    required String from,
    required String to,
    required double amount,
  }) async {
    try {
      final rate = await _getConversionRate(from, to, amount);

      return Paisa(
        amount: amount,
        rate: rate,
        from: Currency.values.firstWhereOrNull((e) => e.name == from)!,
        to: Currency.values.firstWhereOrNull((e) => e.name == to)!,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Return the currency conversion rate for the given [from] and [to] currencies\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rate(Currency.USD, Currency.INR);
  /// ```
  static Future<Paisa> rate(Currency from, Currency to) async {
    try {
      final rate = await _getConversionRate(from.name, to.name, 1);

      return Paisa(amount: 1, rate: rate, from: from, to: to);
    } catch (e) {
      rethrow;
    }
  }

  /// Returns the currency conversion rate for the given [from] and [to] currencies strings\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rateFromString('USD', 'INR'); // Returns the conversion rate for USD to INR
  /// ```
  static Future<Paisa> rateFromString(String from, String to) async {
    try {
      final rate = await _getConversionRate(from, to, 1);

      return Paisa(
        amount: 1,
        rate: rate,
        from: Currency.values.firstWhereOrNull((e) => e.name == from)!,
        to: Currency.values.firstWhereOrNull((e) => e.name == to)!,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Returns the currency conversion rate for the given [from] and [to] country codes.\
  /// Example:
  /// ```dart
  /// CurrencyConvertor.rateFromCountryCode(from:'US', to:'IN');
  /// ```
  static Future<Paisa> rateFromCountryCode({
    required String from,
    required String to,
  }) async {
    final ccFrom = CountryCode.values.fromCode(from);
    final ccTo = CountryCode.values.fromCode(to);
    if (ccFrom == null || ccTo == null) {
      throw Exception('Country code not found');
    }
    try {
      final rate = await _getConversionRate(ccFrom.currency.name, ccTo.currency.name, 1);

      return Paisa(
        amount: 1,
        rate: rate,
        from: ccFrom.currency,
        to: ccTo.currency,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<double> _getConversionRate(String from, String to, double amount) async {
    if (amount <= 0) throw ArgumentError('amount cannot be less than 0');

    final uri = Uri.parse('https://open.er-api.com/v6/latest/$from');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final api = APIResponse.fromJson(response.body);

        final rate = api.rates?.entries.firstWhereOrNull((c) => c.key.toLowerCase() == to.toLowerCase())?.value;
        if (rate == null) {
          throw Exception('Currency not found');
        }

        return rate.toDouble();
      } else {
        throw Exception('Error while converting currency');
      }
    } catch (e) {
      throw Exception('Error while converting currency');
    }
  }
}
