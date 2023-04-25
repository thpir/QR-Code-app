import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import './list_tile_ui.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/qr_code.png'),
              ),
              const Spacer(),
              Text(
                'settings_title'.i18n(),
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'select_theme_subtitle'.i18n(),
                  style: Theme.of(context).textTheme.bodyText1,
                  ),
              ),
              const ListTileUi(),
            ],
          ),
        )
      ],
    ));
  }
}
