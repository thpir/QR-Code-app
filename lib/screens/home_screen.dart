import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/custom_about_dialog.dart';
import '../widgets/portrait_home_layout.dart';
import '../widgets/landscape_home_layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<void> _showAboutDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          CustomAboutDialog customAboutDialog = CustomAboutDialog();
          return customAboutDialog.getDialog(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('app_name'.i18n(),
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        actions: <Widget>[
          IconButton(
            onPressed: _showAboutDialog,
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: (orientation == Orientation.portrait)
          ? const PortraitHomeLayout()
          : const LandscapeHomeLayout()
      ),
      drawer: const CustomDrawer(),
    );
  }
}
