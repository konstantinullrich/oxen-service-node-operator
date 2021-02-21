import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oxen_service_node/generated/l10n.dart';
import 'package:oxen_service_node/src/stores/settings_store.dart';
import 'package:oxen_service_node/src/utils/language.dart';
import 'package:oxen_service_node/src/widgets/base_page.dart';
import 'package:provider/provider.dart';

class ChangeLanguagePage extends BasePage {
  @override
  String get title => S.current.settings_language;

  @override
  Widget body(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final currentLanguage = Provider.of<Language>(context);
    settingsStore.language = currentLanguage;

    final currentColor = Theme.of(context).selectedRowColor;
    final notCurrentColor =
        Theme.of(context).accentTextTheme.subtitle1.backgroundColor;

    return Container(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListView.builder(
          itemCount: languages.values.length,
          itemBuilder: (BuildContext context, int index) {
            final isCurrent = settingsStore.languageCode == null
                ? false
                : languages.keys.elementAt(index) == settingsStore.languageCode;

            return Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              color: isCurrent ? currentColor : notCurrentColor,
              child: ListTile(
                title: Text(
                  languages.values.elementAt(index),
                  style: TextStyle(
                      fontSize: 16.0,
                      color:
                          Theme.of(context).primaryTextTheme.headline6.color),
                ),
                onTap: () async {
                  if (!isCurrent) {
                    settingsStore
                        .setLanguageCode(languages.keys.elementAt(index));
                    Navigator.of(context).pop();
                  }
                },
              ),
            );
          },
        ));
  }
}
