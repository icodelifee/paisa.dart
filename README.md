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
  paisa: ^0.0.3
```

## Usage

```dart
void main(List<String> args) {
  // Converts USD to INR
  print(CurrencyConvertor.convert(from: Currency.USD, to: Currency.INR, amount: 100));
  print(CurrencyConvertor.convertFromString(from: 'USD', to: 'INR', amount: 100));

  // Get exchange rate for USD to INR  
  print(CurrencyConvertor.rate(Currency.USD, Currency.INR));
  print(CurrencyConvertor.rateFromString('USD', 'INR'));
  print(CurrencyConvertor.rateFromCountryCode(from: 'US', to: 'IN'));
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/icodelifee/paisa.dart/issues