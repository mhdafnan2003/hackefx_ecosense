
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ArduinoApiService {
//   static const String _baseUrl = 'http://your-node-red-ip:1880';

//   Future<Map<String, dynamic>> fetchData() async {
//     final response = await http.get(Uri.parse('$_baseUrl/api/arduino-data'));
//     return _processResponse(response);
//   }

//   Future<List<dynamic>> fetchHistory() async {
//     final response = await http.get(Uri.parse('$_baseUrl/api/arduino-history'));
//     return _processResponse(response);
//   }

//   dynamic _processResponse(http.Response response) {
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed with status: ${response.statusCode}');
//     }
//   }
// }