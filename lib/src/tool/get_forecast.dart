import 'package:dart_pi/src/tool/tool.dart';

final class GetForecast extends Tool {
  @override
  String get description => "Get weather forecast for a city";

  @override
  String get name => "get_forecast";

  @override
  Map<String, Object?> get parameters => {
    "type": "object",
    "properties": {
      "city": {"type": "string", "description": "City name"},
    },
    "required": ["city"],
  };

  @override
  Future<String> run(Map<String, dynamic> arg) async {
    final city = arg['city'] as String;
    final forecast = {'Kyiv': 11, 'Tokyo': 9, 'London': 12, 'Lisbon': 24};
    final temp = forecast[city] ?? 10;
    return '{"city": "$city", "temperature_c": $temp, "condition": "sunny"}';
  }
}
