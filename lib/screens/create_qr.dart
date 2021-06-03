import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ShowBarcode extends StatelessWidget {
  final String data;
  const ShowBarcode({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: data,
            width: 400,
            height: 400,
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, HomePage.routeName),
        style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Go to Home"),
        ),
      ),
    );
  }
}
