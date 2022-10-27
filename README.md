# paisa.dart
![Frame 2](https://user-images.githubusercontent.com/18023153/198404390-87d406b9-9107-4b1d-bfe6-49d71f6bc3ab.png)
<center>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
</center>

A simple dart package to converts currencies.
# Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  paisa: ^0.0.1
```

## Usage

```dart
void main(List<String> args) {
  // Converts USD to INR
  print(CurrencyConvertor.convert(from: Currency.USD, to: Currency.INR, amount: 100));
  print(CurrencyConvertor.convertFromString(from: 'USD', to: 'INR', amount: 100));

  // Get exchange rate of USD to INR  
  print(CurrencyConvertor.rate(Currency.USD, Currency.INR));
  print(CurrencyConvertor.rateFromString('USD', 'INR'));
  print(CurrencyConvertor.rateFromCountryCode(from: 'US', to: 'IN'));
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/dartninja/version/issues