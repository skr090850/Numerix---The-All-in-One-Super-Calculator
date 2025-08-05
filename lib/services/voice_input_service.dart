import 'package:speech_to_text/speech_to_text.dart' as stt;

// Yeh class voice input (speech-to-text) ki functionality ko handle karti hai.
class VoiceInputService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _lastWords = '';

  bool get isListening => _isListening;
  String get lastWords => _lastWords;

  // Service ko initialize karta hai.
  Future<bool> initialize() async {
    bool hasSpeech = await _speech.initialize(
      onError: (error) => print('Error: $error'),
      onStatus: (status) => print('Status: $status'),
    );
    return hasSpeech;
  }

  // Voice ko sunna shuru karta hai.
  void startListening(Function(String) onResult) {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          _lastWords = result.recognizedWords;
          onResult(_lastWords); // Callback ko result bhejta hai.
        },
      );
      _isListening = true;
    }
  }

  // Sunna band karta hai.
  void stopListening() {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
    }
  }
}
