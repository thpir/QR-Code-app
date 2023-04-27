import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import './home_screen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result-screen';
  const ResultScreen({
    //required this.result, 
    super.key
  });

  //final String result;

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
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(HomeScreen.routeName, ((route) => false));
            },
            icon: const Icon(Icons.home_filled),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
