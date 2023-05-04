import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../providers/database_provider.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history-screen';
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void _deleteItem(String id, String metaData) {
    Provider.of<DatabaseProvider>(context, listen: false).deleteQrCode(id, metaData);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      key: UniqueKey(),
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'appbar_history_text'.i18n(),
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Scan',
            ),
            Tab(
              text: 'Created',
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            FutureBuilder(
              future: Provider.of<DatabaseProvider>(context, listen: false)
                  .fetchQrCodes('scan'),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<DatabaseProvider>(
                      builder: (context, qrCodes, child) {
                        if (qrCodes.scannedItems.isEmpty) {
                          return child ??
                              Center(
                                child: Text(
                                  'no_scan_history_text'.i18n(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              );
                        } else {
                          return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: qrCodes.scannedItems.length,
                            itemBuilder: (ctx, i) => ListTile(
                              title: Text(qrCodes.scannedItems[i].content),
                              trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteItem(qrCodes.scannedItems[i].id, 'scan');
                              },
                            ),
                            ),
                          );
                        }
                      },
                    ),
            ),
            FutureBuilder(
              future: Provider.of<DatabaseProvider>(context, listen: false)
                  .fetchQrCodes('create'),
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<DatabaseProvider>(
                      builder: (context, qrCodes, child) {
                        if (qrCodes.generatedItems.isEmpty) {
                          return child ??
                              Center(
                                child: Text(
                                  'no_created_history_text'.i18n(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              );
                        } else {
                          return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: qrCodes.generatedItems.length,
                            itemBuilder: (ctx, i) => ListTile(
                              title: Text(qrCodes.generatedItems[i].content),
                              trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteItem(qrCodes.generatedItems[i].id, 'create');
                              },
                            ),
                            ),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
