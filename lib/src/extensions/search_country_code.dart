import 'package:paisa_dart/src/extensions/first_where_or_null.dart';

import '../entities/enums/country_code.dart';

extension CountryCodeX on List<CountryCode> {
  // search by country code
  CountryCode? fromCode(String code) {
    return firstWhereOrNull((e) => e.name.toLowerCase() == code.toLowerCase());
  }
}
