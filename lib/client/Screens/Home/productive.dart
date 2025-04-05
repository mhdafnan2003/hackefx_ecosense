import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class Productive extends StatefulWidget {
  const Productive({super.key});

  @override
  State<Productive> createState() => _ProductiveState();
}

class _ProductiveState extends State<Productive> {
  bool _isLoading = false;
  String _errorMessage = '';
  Map<String, dynamic>? _predictionData;
  // Enter your computer's IP address here - replace with your actual IP
  String _ipAddress = '10.0.20.190'; // Replace with your actual IP
  bool _showGraphs = false;
  Map<String, List<FlSpot>> _graphData = {};

  @override
  void initState() {
    super.initState();
    _fetchPredictions();
    _generateMockGraphData();
  }

  void _generateMockGraphData() {
    final random = Random();
    final components = ['Engine', 'Air', 'Battery', 'Smoke'];
    
    for (var component in components) {
      List<FlSpot> spots = [];
      
      // Starting value between 80-100
      double lastValue = 80 + random.nextDouble() * 20;
      
      // Generate 14 days of data with slight downward trend
      for (int i = 0; i < 14; i++) {
        // Slight downward trend but with some random fluctuation
        double change = random.nextDouble() * 8 - 4; // Random change between -4 and +4
        if (i > 9) {
          // More likely to decrease in recent days
          change = random.nextDouble() * 8 - 5;
        }
        
        lastValue = max(0, min(100, lastValue + change));
        spots.add(FlSpot(i.toDouble(), lastValue));
      }
      
      _graphData[component] = spots;
    }
  }

  Future<void> _fetchPredictions() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      print("Attempting to connect to: http://$_ipAddress:5000/predict");
      
      final response = await http.get(
        Uri.parse('http://$_ipAddress:5000/predict'),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Response received: $responseData");
        
        setState(() {
          _predictionData = responseData;
          _isLoading = false;
        });
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        
        setState(() {
          _errorMessage = 'Failed to load predictions: ${response.statusCode}\nResponse: ${response.body}';
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error during API call: $e");
      
      setState(() {
        _errorMessage = 'Error connecting to AI service: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictive Analysis', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF17CF96),
        actions: [
          IconButton(
            icon: Icon(_showGraphs ? Icons.list : Icons.show_chart),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _showGraphs = !_showGraphs;
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF17CF96),
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Are you sure the Flask server is running?\nMake sure to run "python app.py" in the flask_backend folder.',
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchPredictions,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17CF96),
              ),
              child: const Text('Retry'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Show dialog to manually enter IP
                _showIpInputDialog();
              },
              child: const Text('Change Server IP', style: TextStyle(color: Color(0xFF17CF96))),
            ),
          ],
        ),
      );
    }

    if (_predictionData == null) {
      return const Center(
        child: Text(
          'No prediction data available',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    // Display prediction results
    final prediction = _predictionData!['prediction'] as Map<String, dynamic>? ?? {};
    
    return _showGraphs 
      ? _buildGraphView(prediction)
      : _buildCardView(prediction);
  }

  Widget _buildCardView(Map<String, dynamic> prediction) {
    return ListView(
      children: [
        const Text(
          'Component Health Predictions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildPredictionCard('Engine', prediction['Engine'] ?? 'No data'),
        _buildPredictionCard('Air', prediction['Air'] ?? 'No data'),
        _buildPredictionCard('Battery', prediction['Battery'] ?? 'No data'),
        _buildPredictionCard('Smoke', prediction['Smoke'] ?? 'No data'),
        const SizedBox(height: 20),
        Text(
          'Last Updated: ${_predictionData!['timestamp'] ?? 'Unknown'}',
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchPredictions,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17CF96),
              ),
              child: const Text('Refresh Data'),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                // Show dialog to manually enter IP
                _showIpInputDialog();
              },
              child: const Text('Change Server IP', style: TextStyle(color: Color(0xFF17CF96))),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGraphView(Map<String, dynamic> prediction) {
    return ListView(
      children: [
        const Text(
          'Component Health Trends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        const Text(
          'Last 14 Days',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildGraphCard('Engine', prediction['Engine'] ?? 'No data', Colors.orange),
        _buildGraphCard('Air', prediction['Air'] ?? 'No data', Colors.blue),
        _buildGraphCard('Battery', prediction['Battery'] ?? 'No data', Colors.purple),
        _buildGraphCard('Smoke', prediction['Smoke'] ?? 'No data', Colors.teal),
        const SizedBox(height: 20),
        Text(
          'Last Updated: ${_predictionData!['timestamp'] ?? 'Unknown'}',
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchPredictions,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF17CF96),
              ),
              child: const Text('Refresh Data'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGraphCard(String component, String status, Color color) {
    Color cardColor;
    IconData statusIcon;
    
    if (status.contains('GOOD')) {
      cardColor = Colors.green.withOpacity(0.2);
      statusIcon = Icons.check_circle;
    } else if (status.contains('WARNING')) {
      cardColor = Colors.orange.withOpacity(0.2);
      statusIcon = Icons.warning;
    } else if (status.contains('CRITICAL')) {
      cardColor = Colors.red.withOpacity(0.2);
      statusIcon = Icons.error;
    } else {
      cardColor = Colors.grey.withOpacity(0.2);
      statusIcon = Icons.help;
    }
    
    // Get efficiency value from status string (for the dot at the end of graph)
    double efficiency = 80;
    if (status.contains('GOOD')) {
      efficiency = 90 + Random().nextDouble() * 10; // 90-100
    } else if (status.contains('WARNING')) {
      efficiency = 70 + Random().nextDouble() * 20; // 70-90
    } else if (status.contains('CRITICAL')) {
      efficiency = 30 + Random().nextDouble() * 40; // 30-70
    }
    
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  statusIcon,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        component,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        status,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: _buildGraph(component, color, efficiency),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraph(String component, Color color, double efficiency) {
    if (!_graphData.containsKey(component)) {
      return const Center(child: Text('No data available', style: TextStyle(color: Colors.white70)));
    }
    
    final spots = _graphData[component]!;
    
    // Add the current efficiency value as the latest point
    final allSpots = List<FlSpot>.from(spots);
    if (spots.isNotEmpty) {
      allSpots.add(FlSpot(spots.length.toDouble(), efficiency));
    }
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 20,
          verticalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color(0xFF444444),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Color(0xFF444444),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 2,
              getTitlesWidget: (value, meta) {
                if (value % 2 != 0) {
                  return const SizedBox();
                }
                String text = (14 - value.toInt()).toString();
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xFF444444), width: 1),
        ),
        minX: 0,
        maxX: allSpots.length.toDouble() - 1,
        minY: 0,
        maxY: 100,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.black87,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final daysAgo = (14 - barSpot.x.toInt()).toString();
                return LineTooltipItem(
                  '$daysAgo days ago: ${barSpot.y.toStringAsFixed(1)}%',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: allSpots,
            isCurved: true,
            color: color,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                // Only show the dot for the most recent point
                if (index == allSpots.length - 1) {
                  return FlDotCirclePainter(
                    radius: 6,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: color,
                  );
                }
                // Show smaller dots for other points
                return FlDotCirclePainter(
                  radius: 3,
                  color: color.withOpacity(0.8),
                  strokeWidth: 1,
                  strokeColor: color,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: color.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  void _showIpInputDialog() {
    final TextEditingController ipController = TextEditingController(text: _ipAddress);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Server IP Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: ipController,
              decoration: const InputDecoration(
                labelText: 'IP Address',
                hintText: 'e.g., 192.168.1.5',
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Common values:\n'
              '• 10.0.2.2 - Android Emulator\n'
              '• localhost - iOS Simulator\n'
              '• Your Computer\'s IP - Physical Device',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _ipAddress = ipController.text;
              });
              Navigator.pop(context);
              _fetchPredictions();
            },
            child: const Text('Save & Connect'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF17CF96)),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(String component, String status) {
    Color cardColor;
    IconData statusIcon;
    
    if (status.contains('GOOD')) {
      cardColor = Colors.green.withOpacity(0.2);
      statusIcon = Icons.check_circle;
    } else if (status.contains('WARNING')) {
      cardColor = Colors.orange.withOpacity(0.2);
      statusIcon = Icons.warning;
    } else if (status.contains('CRITICAL')) {
      cardColor = Colors.red.withOpacity(0.2);
      statusIcon = Icons.error;
    } else {
      cardColor = Colors.grey.withOpacity(0.2);
      statusIcon = Icons.help;
    }
    
    return Card(
      color: cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              statusIcon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    component,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for component colors
  Color _getComponentColor(String component) {
    if (component == 'Engine') return Colors.orange;
    if (component == 'Air') return Colors.blue;
    if (component == 'Battery') return Colors.purple;
    if (component == 'Smoke') return Colors.teal;
    return Colors.grey;
  }
  
  // Helper method to get efficiency value based on status
  double _getEfficiencyValue(String status) {
    final random = Random();
    if (status.contains('GOOD')) {
      return 90 + random.nextDouble() * 10; // 90-100
    } else if (status.contains('WARNING')) {
      return 70 + random.nextDouble() * 20; // 70-90
    } else if (status.contains('CRITICAL')) {
      return 30 + random.nextDouble() * 40; // 30-70
    }
    return 50 + random.nextDouble() * 30; // 50-80
  }
}
  