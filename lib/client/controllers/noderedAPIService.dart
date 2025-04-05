
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArduinoController extends GetxController {
  static const String _baseUrl = 'https://65e4-117-239-78-56.ngrok-free.app';

  // Reactive variables
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var sensorData = <String, dynamic>{}.obs;
  var historyData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchData();
    setupPolling();
    super.onInit();
  }

  void setupPolling() {
    // Update every 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      fetchData();
      setupPolling();
    });
  }

  Future<void> fetchData() async {
  try {
    isLoading(true);
    errorMessage('');
    
   // debugPrint('🌐 Making request to: $_baseUrl/arduino-data');
    
    final response = await http.get(
      Uri.parse('$_baseUrl/arduino-data'),
      headers: {
        'Accept': 'application/json',
        'ngrok-skip-browser-warning': 'true',
      },
    ).timeout(const Duration(seconds: 5));

   // debugPrint('🔵 Response status: ${response.statusCode}');
    // debugPrint('📦 Response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
     // debugPrint('🟢 Parsed JSON: $jsonData');
      
      if (jsonData is Map<String, dynamic>) {
        // Print all available keys
       // debugPrint('🔑 Available keys: ${jsonData.keys.join(', ')}');
        
        sensorData.value = jsonData; // Use .value assignment
       // debugPrint('🔄 Updated sensorData: ${sensorData.value}');
      } else {
        throw Exception('Invalid data format received - Expected Map');
      }
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  } catch (e) {
   // debugPrint('🔴 Error: $e');
    errorMessage.value = e.toString();
  } finally {
    isLoading.value = false;
  }
}

  Future<void> fetchHistory() async {
    try {
      isLoading(true);
      final response = await http
          .get(
            Uri.parse('$_baseUrl/api/arduino-history'),
            headers: {'ngrok-skip-browser-warning': 'true'},
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          historyData.assignAll(List<Map<String, dynamic>>.from(data));
        }
      }
    } catch (e) {
      errorMessage('Failed to load history: $e');
    } finally {
      isLoading(false);
    }
  }
}
