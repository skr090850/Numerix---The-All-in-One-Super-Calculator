import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  bool _isScanComplete = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan QR Code'),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Camera View
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              // Scan ko ek hi baar process karne ke liye check.
              if (!_isScanComplete) {
                final List<Barcode> barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  final String? code = barcodes.first.rawValue;
                  if (code != null) {
                    setState(() {
                      _isScanComplete = true;
                    });
                    // Scanned code ko pichhli screen par wapas bhejte hain.
                    Navigator.pop(context, code);
                  }
                }
              }
            },
          ),
          // Scanner Overlay UI
          _buildScannerOverlay(),
        ],
      ),
    );
  }

  // Scanner ke upar dikhne wala guide UI.
  Widget _buildScannerOverlay() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 4),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
