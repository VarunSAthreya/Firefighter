import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../models/machine.dart';
import '../services/database.dart';
import 'machine_details.dart';

class QRScanPage extends StatefulWidget {
  static const routeName = '/scan_qr';
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = 'Unknown';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('QR Scanner'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Scan For Indetifying Machines',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: () => scanQRCode(),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Scan QR Code"),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() async {
        this.qrCode = qrCode;
        debugPrint(qrCode);
        final Machine machine = await DatabaseService.getMachine(id: qrCode);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<MachineDetails>(
            builder: (context) => MachineDetails(
              machine: machine,
            ),
          ),
        );
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
