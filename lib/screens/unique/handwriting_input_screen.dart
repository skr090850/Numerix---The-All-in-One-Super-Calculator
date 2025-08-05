import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';
import 'package:numerix/services/ml_kit_service.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class HandwritingInputScreen extends StatefulWidget {
  const HandwritingInputScreen({super.key});

  @override
  State<HandwritingInputScreen> createState() => _HandwritingInputScreenState();
}

class _HandwritingInputScreenState extends State<HandwritingInputScreen> {
  final MLKitService _mlKitService = MLKitService();
  // InkPoint ko StrokePoint se replace kiya gaya hai.
  final List<StrokePoint> _points = [];
  String _recognizedText = '';
  bool _isModelDownloaded = false;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _checkAndDownloadModel();
  }

  @override
  void dispose() {
    _mlKitService.dispose();
    super.dispose();
  }

  Future<void> _checkAndDownloadModel() async {
    final isDownloaded = await _mlKitService.isModelDownloaded();
    if (isDownloaded) {
      setState(() {
        _isModelDownloaded = true;
      });
    } else {
      setState(() {
        _isDownloading = true;
      });
      await _mlKitService.downloadModel();
      setState(() {
        _isDownloading = false;
        _isModelDownloaded = true;
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      _points.clear();
      _recognizedText = '';
    });
  }

  Future<void> _recognizeText() async {
    if (_points.isEmpty || !_isModelDownloaded) return;
    final text = await _mlKitService.recognizeHandwriting(_points);
    setState(() {
      _recognizedText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Handwriting Input'),
      body: Column(
        children: [
          // Drawing Canvas
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    // InkPoint ko StrokePoint se replace kiya gaya hai.
                    _points.add(StrokePoint(
                      x: details.localPosition.dx,
                      y: details.localPosition.dy,
                      t: DateTime.now().millisecondsSinceEpoch,
                    ));
                  });
                },
                onPanEnd: (details) {
                  // Stroke ke end mein ek khaali point add kar sakte hain,
                  // lekin abhi ke liye poore canvas ko ek hi stroke maan rahe hain.
                },
                child: CustomPaint(
                  painter: DrawingPainter(points: _points),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
          // Recognized Text Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _recognizedText.isEmpty ? 'Draw an equation above' : _recognizedText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Action Buttons
          if (_isDownloading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text('Downloading Math Model...'),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _clearCanvas,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear'),
                  ),
                  ElevatedButton.icon(
                    onPressed: _recognizeText,
                    icon: const Icon(Icons.check),
                    label: const Text('Recognize'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Canvas par drawing banane ke liye CustomPainter.
class DrawingPainter extends CustomPainter {
  // InkPoint ko StrokePoint se replace kiya gaya hai.
  final List<StrokePoint> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    if (points.length < 2) return;

    for (int i = 0; i < points.length - 1; i++) {
      // .toDouble() ki zaroorat nahi hai kyunki x aur y pehle se hi double hain.
      final p1 = Offset(points[i].x, points[i].y);
      final p2 = Offset(points[i + 1].x, points[i + 1].y);
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
