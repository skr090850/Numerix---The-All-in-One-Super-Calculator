// 'hide' keyword ka istemal karke hum material.dart se Ink class ko import hone se rok rahe hain.
// Isse ambiguity error theek ho jayega.
import 'package:flutter/material.dart' hide Ink; 
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

// Yeh class Machine Learning se jude features (khaas kar ke Handwriting Recognition) ko handle karti hai.
class MLKitService {
  // Language model ka code (BCP 47 tag)
  static const String _languageCode = 'zxx-Zsym-x-math';

  // Digital Ink Recognizer ka instance banate hain.
  final DigitalInkRecognizer _digitalInkRecognizer =
      DigitalInkRecognizer(languageCode: _languageCode);
      
  // Model ko manage karne ke liye ek alag manager.
  final DigitalInkRecognizerModelManager _modelManager =
      DigitalInkRecognizerModelManager();

  // Model download hua hai ya nahi, yeh check karta hai.
  Future<bool> isModelDownloaded() async {
    return await _modelManager.isModelDownloaded(_languageCode);
  }

  // Language model ko download karta hai.
  Future<bool> downloadModel() async {
    try {
      print('Downloading math model...');
      // Ab model manager se download karte hain.
      await _modelManager.downloadModel(_languageCode);
      print('Math model downloaded successfully.');
      return true; // Success
    } catch (e) {
      print('Error downloading model: $e');
      return false; // Failure
    }
  }

  // Hath se banaye gaye points (drawing) ko pehchanne ka kaam karta hai.
  Future<String> recognizeHandwriting(List<StrokePoint> points) async {
    if (points.isEmpty) return '';

    try {
      // SAHI TAREKA: Pehle Stroke aur Ink ke khaali object banayein.
      final stroke = Stroke();
      final ink = Ink();

      // Fir unmein values assign karein.
      stroke.points = points;
      ink.strokes = [stroke];
      
      // recognize function ek single Ink object leta hai.
      final List<RecognitionCandidate> candidates =
          await _digitalInkRecognizer.recognize(ink);

      // Sabse acche candidate (sabse zyada confidence wala) ka text return karte hain.
      if (candidates.isNotEmpty) {
        return candidates.first.text;
      }
    } catch (e) {
      print('Error recognizing ink: $e');
    }
    return 'Could not recognize';
  }

  // Resources ko release karne ke liye. Jab service ki zaroorat na ho.
  void dispose() {
    _digitalInkRecognizer.close();
  }
}
