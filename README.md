# paisa.dart
<p align="center">
  <img width="820" alt="2x" src="https://user-images.githubusercontent.com/18023153/198556770-e225ed0b-3bad-4335-a93e-17bc34c02864.png">
</p>

<p align="center">
  <a href="https://pub.dev/packages/paisa">
    <img src="https://img.shields.io/pub/v/paisa?label=pub.dev&labelColor=333940&logo=dart">
  </a>
   <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT">
   </a>
</p>

A simple package to converts currencies for Dart and Flutter.

# Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  paisa: ^0.0.6
```

## Usage

```dart
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

  print(convertedPaisa.convertedAmount); // 8224.3079
  print(convertedStringPaisa.convertedAmount); // 8224.3079

  // Get exchange rate for USD to INR
  final rate = await CurrencyConvertor.rate(Currency.USD, Currency.INR);
  final rateFromString = await CurrencyConvertor.rateFromString('USD', 'INR');
  final rateFromCountryCode = await CurrencyConvertor.rateFromCountryCode(from: 'US', to: 'IN');

  print('Rate for USD -> INR: ${rate.rate}'); // Rate for USD -> INR: 82.243079
  print('Rate for USD -> INR [From String]: ${rateFromString.rate}'); // Rate for USD -> INR [From String]: 82.243079
  print('Rate for US -> IN Currency: ${rateFromCountryCode.rate}'); // Rate for US -> IN Currency: 82.243079
}
```

## Note

This library uses [exchangerate-api](https://www.exchangerate-api.com/) for getting the conversion rates and can be considered a unoffical wrapper for [exchangerate-api](https://www.exchangerate-api.com/)'s Open API.

The library handles the conversion of Currency Code to [ISO 4217 Three Letter Currency Code](https://en.wikipedia.org/wiki/ISO_4217), unless you choose to use ```convertFromString()``` or ```rateFromString()```

According to [exchangerate-api](https://www.exchangerate-api.com/docs/free) the conversion rates are refreshed every 24 hours.


If you would like to know about rate limiting and  all of the supported and unsupported currencies, Please checkout [Supported Currencies Documentation](https://www.exchangerate-api.com/docs/supported-currencies)

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/icodelifee/paisa.dart/issues

Contributions to this repository are welcome.

## License
[MIT](https://choosealicense.com/licenses/mit/)
