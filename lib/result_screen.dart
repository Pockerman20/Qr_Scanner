import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

const bgColor = Colors.black45;
const textColor = Colors.white;
const textColor1 = Colors.white70;

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ResultScreen(
      {super.key, required this.closeScreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: textColor1,
          ),
          onPressed: () {
            closeScreen();
            Navigator.pop(context);
          },
        ),
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
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show QR image
            Container(
              color: textColor,
              child: QrImageView(
                data: code,
                size: 150,
                version: QrVersions.auto,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Scanned Result",
              style: TextStyle(
                color: textColor1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width - 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                },
                child: const Text(
                  "Copy",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
