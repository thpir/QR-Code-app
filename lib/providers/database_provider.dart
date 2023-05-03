import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/qr_code.dart';

class DatabaseProvider with ChangeNotifier {
  List<QrCode> _scannedItems = [];
  List<QrCode> _generatedItems = [];

  // Getter to return a COPY of the original _scannedItems list
  List<QrCode> get scannedItems {
    return [..._scannedItems];
  }

  // Getter to return a COPY of the original _generatedItems list
  List<QrCode> get generatedItems {
    return [..._generatedItems];
  }

  // Method to add a qr-code to the database and update the list of generated or scanned qr-codes
  Future<void> addQrCode(String content, String metaData) async {
    final newQrCode = QrCode(
        id: DateTime.now().toString(), content: content, metaData: metaData);
    metaData == 'scan'
        ? _scannedItems.add(newQrCode)
        : _generatedItems.add(newQrCode);
    notifyListeners();
    await DBHelper.insert('qrcodes', {
      'id': newQrCode.id,
      'content': newQrCode.content,
      'metaData': newQrCode.metaData,
    });
  }

  // Method to delete a qr-code from the database and update the list of generated or scanned qr-codes
  Future<void> deleteQrCode(String id, String metaData) async {
    metaData == 'scan'
        ? _scannedItems.removeWhere((qrCode) => qrCode.id == id)
        : _generatedItems.removeWhere((qrCode) => qrCode.id == id);
    notifyListeners();
    DBHelper.delete('qrcodes', id);
  }

  // A method to display all the scanned OR generated qr-codes that are saved to the database in a list
  Future<void> fetchQrCodes(String metaData) async {
    final qrCodeList = await DBHelper.getData('qrcodes', metaData);
    metaData == 'scan'
        ? _scannedItems = qrCodeList
            .map((item) => QrCode(
                id: item['id'],
                content: item['content'],
                metaData: item['metaData']))
            .toList()
        : _generatedItems = qrCodeList
            .map((item) => QrCode(
                id: item['id'],
                content: item['content'],
                metaData: item['metaData']))
            .toList();
    notifyListeners();
  }
}
