import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_parser/barcode_parser.dart';
import 'package:flutter/services.dart';

import './home_screen.dart';

class ResultScreen extends StatelessWidget {
  //static const routeName = '/result-screen';
  const ResultScreen({required this.result, required this.context, super.key});

  final String result;
  final BuildContext context;

  SnackBar _showMessage(String message) {
    return SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _parseBarcode(String scannedString) {
    BarcodeParser barcodeParser = BarcodeParser();
    Barcode barcode = barcodeParser.parse(scannedString);

    switch (barcode.valueType) {
      case BarcodeValueType.url:
        BarcodeUrl barcodeUrl = barcode as BarcodeUrl;
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  barcodeUrl.rawValue,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl(barcodeUrl.rawValue);
                    },
                    child: Text(
                      'button_text_open_url'.i18n(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case BarcodeValueType.wifi:
        BarcodeWifi barcodeWifi = barcode as BarcodeWifi;
        return Center(
          child: Text(
            "Wifi barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.contactInfo:
        BarcodeContactInfo barcodeContactInfo = barcode as BarcodeContactInfo;
        return Center(
          child: Text(
            "Contact info barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.location:
        BarcodeLocation barcodeLocation = barcode as BarcodeLocation;
        return Center(
          child: Text(
            "Location barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.email:
        BarcodeEmail barcodeEmail = barcode as BarcodeEmail;
        return Center(
          child: Text(
            "Email barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.sms:
        BarcodeSms barcodeSms = barcode as BarcodeSms;
        return Center(
          child: Text(
            "Sms barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.calendarEvent:
        BarcodeCalendarEvent barcodeCalendarEvent =
            barcode as BarcodeCalendarEvent;
        return Center(
          child: Text(
            "Calendar event barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.phone:
        BarcodePhone barcodePhone = barcode as BarcodePhone;
        return Center(
          child: Text(
            "Phone barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.driverLicense:
        BarcodeDriverLicense barcodeDriverLicense =
            barcode as BarcodeDriverLicense;
        return Center(
          child: Text(
            "Driver license barcodes are not yet supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.product:
        BarcodeProduct barcodeProduct = barcode as BarcodeProduct;
        return Center(
          child: Text(
            "Productcode: ${barcodeProduct.rawValue}",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      case BarcodeValueType.text:
        BarcodeText barcodeText = barcode as BarcodeText;
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "TEXT: ${barcodeText.rawValue}",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: barcodeText.rawValue))
                          .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(_showMessage('scaffold_message_copy_clipboard'.i18n())));
                    },
                    child: Text(
                      'button_text_copy_text'.i18n(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Center(
          child: Text(
            "The scanned barcode type is not supported by this app...",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
    }
  }

  Future<void> _launchUrl(String barcode) async {
    Uri url = Uri.parse(barcode);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('appbar_result_text'.i18n(),
              style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, ((route) => false));
              },
              icon: const Icon(Icons.home_filled),
            ),
          ],
        ),
        body: _parseBarcode(result));
  }
}
