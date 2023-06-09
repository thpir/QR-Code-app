import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import './result_screen.dart';

class ScanScreen extends StatefulWidget {
  static const routeName = '/scan-screen';
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  MobileScannerController cameraController = MobileScannerController();

  bool _isPaused = false;

  void _handleDetect(List<Barcode> barcodes) {
    if (_isPaused) {
      return;
    }
    if (barcodes.isNotEmpty) {
      final Barcode firstBarcode = barcodes.first;
      debugPrint('Barcode found! ${firstBarcode.rawValue}');
      setState(() {
        _isPaused = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(result: firstBarcode.rawValue.toString(), context: context,),
          )).then((_) => setState(() {
            _isPaused = false;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'appbar_scan_text'.i18n(),
          style: const TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return Icon(Icons.flash_off,
                        color: Theme.of(context).focusColor);
                  case TorchState.on:
                    return Icon(Icons.flash_on,
                        color: Theme.of(context).focusColor);
                }
              },
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return Icon(Icons.camera_front,
                        color: Theme.of(context).focusColor);
                  case CameraFacing.back:
                    return Icon(Icons.camera_rear,
                        color: Theme.of(context).focusColor);
                }
              },
            ),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          _handleDetect(barcodes);
        },
      ),
    );
  }
}
