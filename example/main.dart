// ignore_for_file: avoid_print

import 'package:paisa/paisa.dart';

void main(List<String> args) {
  // Converts USD to INR
  print(CurrencyConvertor.convert(
    from: Currency.USD,
    to: Currency.INR,
    amount: 100,
  ));

  print(CurrencyConvertor.convertFromString(
    from: 'USD',
    to: 'INR',
    amount: 100,
  ));

  // Get exchange rate for USD to INR
  print(CurrencyConvertor.rate(Currency.USD, Currency.INR));
  print(CurrencyConvertor.rateFromString('USD', 'INR'));
  print(CurrencyConvertor.rateFromCountryCode(from: 'US', to: 'IN'));
}
