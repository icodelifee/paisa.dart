import 'package:paisa/paisa.dart';

class Paisa {
  const Paisa({
    required this.from,
    required this.to,
    required this.amount,
    required this.rate,
  });

  final Currency from;
  final Currency to;
  final double amount;
  final double rate;

  /// Returns converted amount from the given [amount] and [rate]
  double get convertedAmount => amount * rate;

  String get toCurrencySymbol => to.currencySymbol;
  String get fromCurrencySymbol => from.currencySymbol;

  @override
  String toString() {
    return 'Paisa(from: $from, to: $to, amount: $amount, rate: $rate)';
  }
}
