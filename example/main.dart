// ignore_for_file: avoid_print

import 'package:paisa/paisa.dart';

void main(List<String> args) async {
  // Converts USD to INR
  final convertedPaisa = await CurrencyConvertor.convert(
    from: Currency.USD,
    to: Currency.INR,
    amount: 100,
  );

  final convertedStringPaisa = await CurrencyConvertor.convertFromString(
    from: 'USD',
    to: 'INR',
    amount: 100,
  );

  print(convertedPaisa.convertedAmount);
  print(convertedStringPaisa.convertedAmount);

  // Get exchange rate for USD to INR
  final rate = await CurrencyConvertor.rate(Currency.USD, Currency.INR);
  final rateFromString = await CurrencyConvertor.rateFromString('USD', 'INR');
  final rateFromCountryCode = await CurrencyConvertor.rateFromCountryCode(from: 'US', to: 'IN');

  print('Rate for USD -> INR: ${rate.rate}');
  print('Rate for USD -> INR [From String]: ${rateFromString.rate}');
  print('Rate for US -> IN Currency: ${rateFromCountryCode.rate}');
}
