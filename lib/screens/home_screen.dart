import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/custom_about_dialog.dart';

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
          ? Column(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 15),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                size: 150,
                                color: Theme.of(context).focusColor,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                alignment: Alignment.bottomRight,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: Icon(
                                    Icons.camera,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Scan',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 30),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 150,
                                color: Theme.of(context).focusColor,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                alignment: Alignment.bottomRight,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: Icon(
                                    Icons.add,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Create',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
          : Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 15, bottom: 30),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                size: 150,
                                color: Theme.of(context).focusColor,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                alignment: Alignment.bottomRight,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: Icon(
                                    Icons.camera,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Scan',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 15, right: 30, bottom: 30),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Theme.of(context).backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 150,
                                color: Theme.of(context).focusColor,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                alignment: Alignment.bottomRight,
                                child: const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black87,
                                  child: Icon(
                                    Icons.add,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Create',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
