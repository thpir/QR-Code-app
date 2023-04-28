import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localization/localization.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/custom_drawer.dart';
import '../widgets/custom_about_dialog.dart';
import '../screens/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  final qrKey = GlobalKey();
  var qrData = '';
  var _isButtonDisabled = true;

  Future<void> _showAboutDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          CustomAboutDialog customAboutDialog = CustomAboutDialog();
          return customAboutDialog.getDialog(context);
        });
  }

  void takeScreenShot() async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // We can increse the size of QR using pixel ratio
      final image = await boundary.toImage(pixelRatio: 5.0); 
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        // getting directory of our phone
        final directory = (await getApplicationDocumentsDirectory()).path; 
        final imgFile = File(
          '$directory/${DateTime.now()}thpir_qr_generator.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          //In here you can show snackbar or do something in the backend at successfull download
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextFieldChange);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onTextFieldChange() {
    setState(() {
      _isButtonDisabled = controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'scan_divider_text'.i18n(),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(ScanScreen.routeName);
                },
                icon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.black,
                ),
                label: Text(
                  'scan_button_text'.i18n(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'create_divider_text'.i18n(),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'textfield_url_text'.i18n(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ElevatedButton.icon(
                onPressed: _isButtonDisabled
                    ? null
                    : () {
                        setState(() {
                          qrData = controller.text;
                        });
                      },
                icon: const Icon(
                  Icons.qr_code_2,
                  color: Colors.black,
                ),
                label: Text(
                  'generate_qr_code_button_text'.i18n(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              width: 300,
              height: 300,
              alignment: Alignment.center,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Theme.of(context).backgroundColor,
                child: Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  child: RepaintBoundary(
                      key: qrKey,
                      child: qrData == ''
                          ? SizedBox(
                              height: 250,
                              width: 250,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const Icon(
                                      Icons.qr_code_2,
                                      color: Colors.black26,
                                      size: 250,
                                    ),
                                    Text(
                                      'no_qr_text'.i18n(),
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                QrImage(
                                  data: qrData,
                                  // embeddedImage: TODO
                                  // semanticsLabel: TODO
                                  size: 250,
                                  backgroundColor: Colors.white,
                                  version: QrVersions.auto,
                                ),
                                Container(
                                  constraints: const BoxConstraints.expand(),
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          qrData = '';
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      )),
                                )
                              ],
                            )),
                ),
              ),
            )
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: qrData == ''
          ? null
          : FloatingActionButton(
              onPressed: takeScreenShot,
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.save,
                color: Colors.black,
              ),
            ),
    );
  }
}
