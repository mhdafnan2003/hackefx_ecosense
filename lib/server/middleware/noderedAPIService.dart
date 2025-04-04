import 'package:http/http.dart' as http;
import 'dart:convert';

class ArduinoDataService {
  static const String _baseUrl = 'http://your-node-red-ip:1880';
  static const int _timeoutSeconds = 5;

  Future<Map<String, dynamic>> getArduinoData() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/arduino-data'),
    ).timeout(Duration(seconds: _timeoutSeconds));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load Arduino data');
    }
  }

  Future<List<Map<String, dynamic>>> getHistoricalData() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/arduino-history'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load history');
    }
  }
}