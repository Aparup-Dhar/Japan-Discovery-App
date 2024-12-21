import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' as lt;  // Alias lottie package

import 'attractions_screen.dart';
import 'language_learning_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrefectureMapScreen(),
    );
  }
}

class PrefectureMapScreen extends StatefulWidget {
  const PrefectureMapScreen({Key? key}) : super(key: key);

  @override
  _PrefectureMapScreenState createState() => _PrefectureMapScreenState();
}

class _PrefectureMapScreenState extends State<PrefectureMapScreen> {
  final List<Map<String, dynamic>> prefectures = [
    {"name": "Tokyo", "coordinates": LatLng(35.6895, 139.6917)},
    {"name": "Hokkaido", "coordinates": LatLng(43.0642, 141.3469)},
    {"name": "Osaka", "coordinates": LatLng(34.6937, 135.5023)},
    {"name": "Kyoto", "coordinates": LatLng(35.0116, 135.7681)},
    {"name": "Kanagawa", "coordinates": LatLng(35.4437, 139.6380)},
    {"name": "Hiroshima", "coordinates": LatLng(34.3963, 132.4596)},
    {"name": "Kumamoto", "coordinates": LatLng(32.7900, 130.7418)},
    {"name": "Okinawa", "coordinates": LatLng(26.2124, 127.6809)},
    {"name": "Sendai (Miyagi)", "coordinates": LatLng(38.2682, 140.8694)},
    {"name": "Nagano", "coordinates": LatLng(36.6513, 138.1810)},
    {"name": "Fukuoka", "coordinates": LatLng(33.6064, 130.4184)},
    {"name": "Fukushima", "coordinates": LatLng(37.7503, 140.4676)},
    {"name": "Ibaraki", "coordinates": LatLng(36.3418, 140.4468)},
    {"name": "Wakayama", "coordinates": LatLng(34.2257, 135.1675)},
    {"name": "Kagoshima", "coordinates": LatLng(31.5966, 130.5571)},
    {"name": "Fukui", "coordinates": LatLng(36.0652, 136.2216)},
    {"name": "Mie", "coordinates": LatLng(34.7303, 136.5086)},
    {"name": "Saitama", "coordinates": LatLng(35.8617, 139.6455)},
    {"name": "Niigata", "coordinates": LatLng(37.5408, 138.9031)},
    {"name": "Gunma", "coordinates": LatLng(36.2048, 138.2529)},
  ];

  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _showPrefectureInfo(BuildContext context, String prefectureName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFE1C28F),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Text(
                prefectureName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Explore attractions and learn more about this prefecture.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttractionsScreen(
                        prefectureName: prefectureName,
                        latitude: prefectures
                            .firstWhere((prefecture) =>
                        prefecture['name'] == prefectureName)['coordinates']
                            .latitude,
                        longitude: prefectures
                            .firstWhere((prefecture) =>
                        prefecture['name'] == prefectureName)['coordinates']
                            .longitude,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width - 64, 50),
                  backgroundColor: Colors.transparent, // Make the background transparent
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.green.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0, // Ensures the button has a minimum height
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'View Attractions',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Set text color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Learn the Language screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageLearningScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width - 64, 50),
                  backgroundColor: Colors.transparent, // Set transparent to see the gradient
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.green.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0, // Ensures the button has a minimum height
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Learn the Language',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Set text color
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(35.6762, 139.6503), // Centered on Japan
              zoom: 5.5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                "https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: prefectures.map((prefecture) {
                  return Marker(
                    point: prefecture['coordinates'],
                    width: 40,
                    height: 60,
                    builder: (context) => GestureDetector(
                      onTap: () =>
                          _showPrefectureInfo(context, prefecture['name']),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 30,
                          ),
                          SizedBox(height: 5),
                          Text(
                            prefecture['name'],
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.shade800],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to the extremes
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side content
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 55),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'EXPLORE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const Text(
                            'JAPAN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Right side content (Lottie animation)
                  SizedBox(
                    height: 120, // Height of the Lottie animation
                    child: lt.Lottie.network(
                      'https://lottie.host/15be4acc-d171-4958-a087-eb84166b962f/dZPZDNy3nT.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              children: [
                // Zoom In Button
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.yellow.shade800, Colors.yellow.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.compass,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    _mapController.move(
                        _mapController.center, _mapController.zoom + 1);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.yellow.shade800, Colors.yellow.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Zoom Out Button
                GestureDetector(
                  onTap: () {
                    _mapController.move(
                        _mapController.center, _mapController.zoom - 1);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.yellow.shade800, Colors.yellow.shade300],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
