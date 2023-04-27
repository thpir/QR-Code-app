import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});
  static const routeName = '/create-screen';

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController controller = TextEditingController();
  final qrKey = GlobalKey();
  var qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'appbar_create_text'.i18n(),
          style: const TextStyle(
              fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'textfield_url_text'.i18n(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    qrData = controller.text;
                  });
                },
                child: Text(
                  'generate_qr_code_button_text'.i18n(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 16,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Card(
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
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : QrImage(
                          data: qrData,
                          // embeddedImage: TODO
                          // semanticsLabel: TODO
                          size: 250,
                          backgroundColor: Colors.white,
                          version: QrVersions.auto,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
