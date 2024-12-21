import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class LanguageLearningScreen extends StatefulWidget {
  const LanguageLearningScreen({Key? key}) : super(key: key);

  @override
  _LanguageLearningScreenState createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends State<LanguageLearningScreen> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final GoogleTranslator _translator = GoogleTranslator();

  String _translatedText = '';

  // Gradient colors for the translated text container and button
  final LinearGradient greenGradient = LinearGradient(
    colors: [Colors.green.shade700, Colors.green.shade300],
  );

  // Function to translate text and speak it
  Future<void> _translateAndSpeak() async {
    String inputText = _controller.text;
    if (inputText.isNotEmpty) {
      // Translate the text to Japanese
      var translation = await _translator.translate(inputText, to: 'ja');
      setState(() {
        _translatedText = translation.text;
      });

      // Speak the translated text in Japanese
      await _flutterTts.setLanguage('ja'); // Set language to Japanese
      await _flutterTts.setPitch(1.0); // Optional: Adjust pitch
      await _flutterTts.speak(_translatedText); // Speak the translated text
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
          title: const Text(
            'Speak in Japanese',
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
                colors: [Colors.yellow.shade700, Colors.yellow.shade300], // Gradient for AppBar
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
        child: Column(
          children: [
            // Text input field with gradient background and border
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                cursorColor: Colors.white,
                controller: _controller,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 0),
                  ),
                  labelText: 'Enter text to translate',
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.green.shade300,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ), // Green background
                ),
                maxLines: 6,
              ),
            ),
            // Translated text container with gradient
            Center(
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(16),
                width: double.infinity, // Full width for the translated text container
                decoration: BoxDecoration(
                  gradient: greenGradient, // Green gradient for the translated text
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _translatedText.isEmpty
                      ? 'Translated text will appear here'
                      : _translatedText,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // Translate button with gradient background
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [Colors.green, Colors.green.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _translateAndSpeak,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width - 64, 50),
                    backgroundColor: Colors.green, // Set transparent to see the gradient
                    shadowColor: Colors.transparent,
                    elevation: 10,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: 50.0, // Ensures the button has a minimum height
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Translate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
