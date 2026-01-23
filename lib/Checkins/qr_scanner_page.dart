import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For HapticFeedback
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:nightlifequest/checkins/checkin_service.dart';
import 'package:nightlifequest/core/app_theme.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _isScanning = true;
  String _lastScanned = '';

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (!_isScanning) return;

      final code = scanData.code;
      if (code == null || code == _lastScanned) return;

      // Prevent rapid re-scans
      setState(() {
        _isScanning = false;
        _lastScanned = code;
      });

      // 🔊 Haptic + Visual Feedback
      HapticFeedback.mediumImpact();

      // 📥 Process check-in
      _processCheckIn(code);
    });
  }

  Future<void> _processCheckIn(String code) async {
    try {
      final checkinService = CheckinService();
      await checkinService.processCheckIn(code); // Your Supabase logic here

      if (!mounted) return;

      // Show success feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🎉 Check-in successful!', textAlign: TextAlign.center),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Optional: auto-close after success
      // Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Failed: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      // Re-enable scanning on failure
      setState(() {
        _isScanning = true;
        _lastScanned = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔲 Fullscreen QR Scanner
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.deepPurpleAccent,
              borderRadius: 16,
              borderLength: 30,
              borderWidth: 4,
              cutOutSize: MediaQuery.of(context).size.width * 0.75,
            ),
          ),

          // 🎯 Big "SCAN HERE" Indicator (Centered)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24, width: 1),
              ),
              child: const Text(
                'SCAN QR CODE HERE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // ❌ Close Button (Top Right)
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 32),
              ),
            ),
          ),

          // ⏳ Scanning Disabled Overlay (optional)
          if (!_isScanning)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
