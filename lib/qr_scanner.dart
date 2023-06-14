import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/qr_overlay.dart';
import 'package:qr_scanner/result_screen.dart';

const bgColor = Colors.black45;
const textColor = Colors.white;
const textColor1 = Colors.white70;

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // drawer: const Drawer(),
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(
            Icons.qr_code_scanner_outlined,
            size: 40,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                controller.toggleTorch();
              },
              icon: Icon(
                Icons.flash_on_outlined,
                color: isFlashOn ? Colors.blue : Colors.grey.shade200,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                controller.switchCamera();
              },
              icon: Icon(
                Icons.camera_front_outlined,
                color: isFrontCamera ? Colors.blue : Colors.grey.shade200,
              )),
        ],
        iconTheme: const IconThemeData(color: Colors.white70),
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: const [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning starts automatically",
                    style: TextStyle(
                      color: textColor1,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        String code = barcode.rawValue ?? '---';
                        isScanCompleted = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                    closeScreen: closeScreen,
                                    code: code,
                                  )),
                        );
                      }
                    },
                  ),
                  const QRScannerOverlay(overlayColour: bgColor),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Developed by Diwakar",
                  style: TextStyle(
                    color: textColor1,
                    fontSize: 14,
                    letterSpacing: 1,
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
