import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class AttractionsScreen extends StatefulWidget {
  final String prefectureName;
  final double latitude;
  final double longitude;

  const AttractionsScreen({
    Key? key,
    required this.prefectureName,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<AttractionsScreen> createState() => _AttractionsScreenState();
}

class _AttractionsScreenState extends State<AttractionsScreen> {
  final SwipableStackController _controller = SwipableStackController();

  // List of linear gradients from green to light green
  final List<LinearGradient> gradients = [
    LinearGradient(colors: [Colors.red.shade700, Colors.red.shade300]),
    LinearGradient(colors: [Colors.green.shade700, Colors.green.shade300]),
    LinearGradient(colors: [Colors.blue.shade700, Colors.blue.shade300]),
    LinearGradient(colors: [Colors.purple.shade700, Colors.purple.shade300]),
  ];

  // List of Lottie animation URLs
  final List<String> lottieUrls = [
    'https://lottie.host/ac575625-5556-449b-b70e-4042c18a5785/fm3MWxX1hN.json', // Example URL 1
    'https://lottie.host/76e294d1-2354-4a66-8668-c09e4d4e74bc/1gehEwI9c5.json', // Example URL 2
    'https://lottie.host/3fac05f9-590e-4e04-8fb9-c89aac605d74/aV8d4itk5H.json', // Example URL 3
  ];

  Future<List<Map<String, String>>> fetchAttractions() async {
    final dio = Dio();

    // Replace with your actual RapidAPI credentials
    const String apiKey = 'a2b31dfafdmsh9966f416875694dp11babejsn31a3ce3398b6';
    const String apiHost = 'wft-geo-db.p.rapidapi.com';

    final String url =
        'https://wft-geo-db.p.rapidapi.com/v1/geo/locations/+${widget.latitude}+${widget.longitude}/nearbyPlaces';

    try {
      final response = await dio.get(
        url,
        queryParameters: {
          'radius': 100, // Radius in kilometers
          'limit': 10,   // Number of results
        },
        options: Options(
          headers: {
            'X-RapidAPI-Key': apiKey,
            'X-RapidAPI-Host': apiHost,
          },
        ),
      );

      // Parse the response and extract the required fields
      final data = response.data['data'] as List<dynamic>;
      return data.map((place) {
        return {
          'type': place['type'] as String,
          'name': place['name'] as String,
          'region': place['region'] as String,
        };
      }).toList();
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with Gradient
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Colors.green, // Change back button color to green
          ),
          title: Text(
            '${widget.prefectureName} Attractions',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent, // Transparent background to show gradient
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow.shade700, Colors.yellow.shade300], // Change the gradient colors here
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade700, Colors.yellow.shade300], // Body gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List<Map<String, String>>>(
          future: fetchAttractions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 6.0,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error fetching attractions. Please try again.',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No attractions found in this area.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              final attractions = snapshot.data!;

              return SwipableStack(
                controller: _controller,
                itemCount: attractions.length,
                stackClipBehaviour: Clip.none,
                builder: (context, properties) {
                  final attraction = attractions[properties.index];

                  // Randomly select a gradient and Lottie animation
                  final gradient = gradients[properties.index % gradients.length];
                  final lottieUrl = lottieUrls[properties.index % lottieUrls.length];

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.8,
                        padding: const EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: gradient, // Apply random gradient
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Lottie animation in the center
                            Center(
                              child: Lottie.network(lottieUrl),
                            ),
                            // Attraction name on the top left
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                attraction['name']!,
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            // Other information below the name
                            Text(
                              '${attraction['type']} - ${attraction['region']}',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
