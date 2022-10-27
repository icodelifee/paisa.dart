import 'dart:convert';

class APIResponse {
  final String? result;
  final String? provider;
  final String? documentation;
  final String? termsOfUse;
  final int? timeLastUpdateUnix;
  final String? timeLastUpdateUtc;
  final int? timeNextUpdateUnix;
  final String? timeNextUpdateUtc;
  final int? timeEolUnix;
  final String? baseCode;
  final Map<String, num>? rates;

  const APIResponse({
    this.result,
    this.provider,
    this.documentation,
    this.termsOfUse,
    this.timeLastUpdateUnix,
    this.timeLastUpdateUtc,
    this.timeNextUpdateUnix,
    this.timeNextUpdateUtc,
    this.timeEolUnix,
    this.baseCode,
    this.rates,
  });

  factory APIResponse.fromMap(Map<String, dynamic> data) {
    return APIResponse(
      result: data['result'] as String?,
      provider: data['provider'] as String?,
      documentation: data['documentation'] as String?,
      termsOfUse: data['terms_of_use'] as String?,
      timeLastUpdateUnix: data['time_last_update_unix'] as int?,
      timeLastUpdateUtc: data['time_last_update_utc'] as String?,
      timeNextUpdateUnix: data['time_next_update_unix'] as int?,
      timeNextUpdateUtc: data['time_next_update_utc'] as String?,
      timeEolUnix: data['time_eol_unix'] as int?,
      baseCode: data['base_code'] as String?,
      rates: Map<String, num>.from(data['rates']),
    );
  }

  Map<String, dynamic> toMap() => {
        'result': result,
        'provider': provider,
        'documentation': documentation,
        'terms_of_use': termsOfUse,
        'time_last_update_unix': timeLastUpdateUnix,
        'time_last_update_utc': timeLastUpdateUtc,
        'time_next_update_unix': timeNextUpdateUnix,
        'time_next_update_utc': timeNextUpdateUtc,
        'time_eol_unix': timeEolUnix,
        'base_code': baseCode,
        'rates': rates,
      };

  factory APIResponse.fromJson(String data) {
    return APIResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
