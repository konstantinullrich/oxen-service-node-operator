// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome,\nOXEN Service Node Operator`
  String get welcome {
    return Intl.message(
      'Welcome,\nOXEN Service Node Operator',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Here you can watch Service Nodes you run or contributed to.`
  String get welcome_first_line {
    return Intl.message(
      'Here you can watch Service Nodes you run or contributed to.',
      name: 'welcome_first_line',
      desc: '',
      args: [],
    );
  }

  /// `Add a Service Node below to get started.`
  String get add_node_to_get_started {
    return Intl.message(
      'Add a Service Node below to get started.',
      name: 'add_node_to_get_started',
      desc: '',
      args: [],
    );
  }

  /// `Add a Service Node`
  String get add_service_node {
    return Intl.message(
      'Add a Service Node',
      name: 'add_service_node',
      desc: '',
      args: [],
    );
  }

  /// `No route defined for {name}`
  String router_no_route(Object name) {
    return Intl.message(
      'No route defined for $name',
      name: 'router_no_route',
      desc: '',
      args: [name],
    );
  }

  /// `Add Service Node`
  String get add_service_node_title {
    return Intl.message(
      'Add Service Node',
      name: 'add_service_node_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Public Key`
  String get public_key {
    return Intl.message(
      'Public Key',
      name: 'public_key',
      desc: '',
      args: [],
    );
  }

  /// `Public Key too long`
  String get error_public_key_too_long {
    return Intl.message(
      'Public Key too long',
      name: 'error_public_key_too_long',
      desc: '',
      args: [],
    );
  }

  /// `Public Key too short`
  String get error_public_key_too_short {
    return Intl.message(
      'Public Key too short',
      name: 'error_public_key_too_short',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}