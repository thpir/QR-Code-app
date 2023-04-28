import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

import './home_screen.dart';

class ResultScreen extends StatelessWidget {
  //static const routeName = '/result-screen';
  const ResultScreen({required this.result, super.key});

  final String result;

  bool _isUrl(String string) {
    // Define a regular expression to match URLs
    RegExp urlRegex = RegExp(
        r"(http://|https://)?([a-zA-Z0-9]+[.])+[a-zA-Z]{2,6}(:[0-9]{1,5})?(/[\w#!:.?+=&%@!-/])?",
        multiLine: false,
        caseSensitive: false);

    // Use the RegExp class to check if the string matches the URL pattern
    return urlRegex.hasMatch(string);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // When a barcode is detected we will decode the content and check if the
    //barcode contains a valid URL. If this is the case we will navigate to
    //the webpage. If no valid URL is found we will display the content as a
    //string value in the result page.
    if (_isUrl(result)) {
        Uri url = Uri.parse(result);
        _launchUrl(url);
    }
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
      body: Center(
        child: Text(result),
      ),
    );
  }
}
