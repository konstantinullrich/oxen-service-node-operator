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

  /// `Here you can watch Service Nodes you run or contribute to.`
  String get welcome_first_line {
    return Intl.message(
      'Here you can watch Service Nodes you run or contribute to.',
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

  /// `Add Daemon`
  String get add_daemon {
    return Intl.message(
      'Add Daemon',
      name: 'add_daemon',
      desc: '',
      args: [],
    );
  }

  /// `Add Daemon`
  String get title_add_daemon {
    return Intl.message(
      'Add Daemon',
      name: 'title_add_daemon',
      desc: '',
      args: [],
    );
  }

  /// `Edit Daemons`
  String get title_edit_daemons {
    return Intl.message(
      'Edit Daemons',
      name: 'title_edit_daemons',
      desc: '',
      args: [],
    );
  }

  /// `Add Service Node`
  String get title_add_service_node {
    return Intl.message(
      'Add Service Node',
      name: 'title_add_service_node',
      desc: '',
      args: [],
    );
  }

  /// `Edit Service Nodes`
  String get title_edit_service_node {
    return Intl.message(
      'Edit Service Nodes',
      name: 'title_edit_service_node',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get title_dashboard {
    return Intl.message(
      'Dashboard',
      name: 'title_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get title_settings {
    return Intl.message(
      'Settings',
      name: 'title_settings',
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

  /// `IP Address`
  String get public_ip {
    return Intl.message(
      'IP Address',
      name: 'public_ip',
      desc: '',
      args: [],
    );
  }

  /// `Daemon Address`
  String get daemon_address {
    return Intl.message(
      'Daemon Address',
      name: 'daemon_address',
      desc: '',
      args: [],
    );
  }

  /// `Daemon Port`
  String get daemon_port {
    return Intl.message(
      'Daemon Port',
      name: 'daemon_port',
      desc: '',
      args: [],
    );
  }

  /// `Your Service Nodes`
  String get your_service_nodes {
    return Intl.message(
      'Your Service Nodes',
      name: 'your_service_nodes',
      desc: '',
      args: [],
    );
  }

  /// `All {total} nodes operational`
  String health_all_nodes(Object total) {
    return Intl.message(
      'All $total nodes operational',
      name: 'health_all_nodes',
      desc: '',
      args: [total],
    );
  }

  /// `{healthyNodes} out of {total} nodes\nare operational`
  String health_out_of_nodes(Object healthyNodes, Object total) {
    return Intl.message(
      '$healthyNodes out of $total nodes\nare operational',
      name: 'health_out_of_nodes',
      desc: '',
      args: [healthyNodes, total],
    );
  }

  /// `No nodes are operational!`
  String get health_no_nodes {
    return Intl.message(
      'No nodes are operational!',
      name: 'health_no_nodes',
      desc: '',
      args: [],
    );
  }

  /// `Storage Server`
  String get storage_server {
    return Intl.message(
      'Storage Server',
      name: 'storage_server',
      desc: '',
      args: [],
    );
  }

  /// `Last Reward`
  String get last_reward {
    return Intl.message(
      'Last Reward',
      name: 'last_reward',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Swarm ID`
  String get swarm_id {
    return Intl.message(
      'Swarm ID',
      name: 'swarm_id',
      desc: '',
      args: [],
    );
  }

  /// `Last Reward Height`
  String get last_reward_height {
    return Intl.message(
      'Last Reward Height',
      name: 'last_reward_height',
      desc: '',
      args: [],
    );
  }

  /// `Earned Downtime Blocks`
  String get earned_downtime_blocks {
    return Intl.message(
      'Earned Downtime Blocks',
      name: 'earned_downtime_blocks',
      desc: '',
      args: [],
    );
  }

  /// `Checkpoints`
  String get checkpoint_blocks {
    return Intl.message(
      'Checkpoints',
      name: 'checkpoint_blocks',
      desc: '',
      args: [],
    );
  }

  /// `Pulses`
  String get pulse_blocks {
    return Intl.message(
      'Pulses',
      name: 'pulse_blocks',
      desc: '',
      args: [],
    );
  }

  /// `Registration Height`
  String get registration_height {
    return Intl.message(
      'Registration Height',
      name: 'registration_height',
      desc: '',
      args: [],
    );
  }

  /// `Registration Hardfork Version`
  String get registration_hf_version {
    return Intl.message(
      'Registration Hardfork Version',
      name: 'registration_hf_version',
      desc: '',
      args: [],
    );
  }

  /// `Node Version`
  String get service_node_version {
    return Intl.message(
      'Node Version',
      name: 'service_node_version',
      desc: '',
      args: [],
    );
  }

  /// `Node/Storage Server/Lokinet Version`
  String get software_versions {
    return Intl.message(
      'Node/Storage Server/lokinet Version',
      name: 'software_versions',
      desc: '',
      args: [],
    );
  }

  /// `Storage Server Version`
  String get storage_server_version {
    return Intl.message(
      'Storage Server Version',
      name: 'storage_server_version',
      desc: '',
      args: [],
    );
  }

  /// `Lokinet Version`
  String get lokinet_version {
    return Intl.message(
      'Lokinet Version',
      name: 'lokinet_version',
      desc: '',
      args: [],
    );
  }

  /// `Node Operator`
  String get service_node_operator {
    return Intl.message(
      'Node Operator',
      name: 'service_node_operator',
      desc: '',
      args: [],
    );
  }

  /// `Last Uptime Proof`
  String get last_uptime_proof {
    return Intl.message(
      'Last Uptime Proof',
      name: 'last_uptime_proof',
      desc: '',
      args: [],
    );
  }

  /// `Next Reward:`
  String get next_reward {
    return Intl.message(
      'Next Reward:',
      name: 'next_reward',
      desc: '',
      args: [],
    );
  }

  /// `~ in {nextReward} blocks`
  String estimated_reward_block(Object nextReward) {
    return Intl.message(
      '~ in $nextReward blocks',
      name: 'estimated_reward_block',
      desc: '',
      args: [nextReward],
    );
  }

  /// `Node is unlocking`
  String get unlocking_node {
    return Intl.message(
      'Node is unlocking',
      name: 'unlocking_node',
      desc: '',
      args: [],
    );
  }

  /// `in {unlockBlock} blocks`
  String estimated_node_unlock(Object unlockBlock) {
    return Intl.message(
      'in $unlockBlock blocks',
      name: 'estimated_node_unlock',
      desc: '',
      args: [unlockBlock],
    );
  }

  /// `Copied {title} to clipboard`
  String copied_to_clipboard(Object title) {
    return Intl.message(
      'Copied $title to clipboard',
      name: 'copied_to_clipboard',
      desc: '',
      args: [title],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} minutes ago`
  String minutes_ago(Object minutes) {
    return Intl.message(
      '$minutes minutes ago',
      name: 'minutes_ago',
      desc: '',
      args: [minutes],
    );
  }

  /// `January`
  String get month_january {
    return Intl.message(
      'January',
      name: 'month_january',
      desc: '',
      args: [],
    );
  }

  /// `February`
  String get month_february {
    return Intl.message(
      'February',
      name: 'month_february',
      desc: '',
      args: [],
    );
  }

  /// `March`
  String get month_march {
    return Intl.message(
      'March',
      name: 'month_march',
      desc: '',
      args: [],
    );
  }

  /// `April`
  String get month_april {
    return Intl.message(
      'April',
      name: 'month_april',
      desc: '',
      args: [],
    );
  }

  /// `May`
  String get month_may {
    return Intl.message(
      'May',
      name: 'month_may',
      desc: '',
      args: [],
    );
  }

  /// `June`
  String get month_june {
    return Intl.message(
      'June',
      name: 'month_june',
      desc: '',
      args: [],
    );
  }

  /// `July`
  String get month_july {
    return Intl.message(
      'July',
      name: 'month_july',
      desc: '',
      args: [],
    );
  }

  /// `August`
  String get month_august {
    return Intl.message(
      'August',
      name: 'month_august',
      desc: '',
      args: [],
    );
  }

  /// `September`
  String get month_september {
    return Intl.message(
      'September',
      name: 'month_september',
      desc: '',
      args: [],
    );
  }

  /// `October`
  String get month_october {
    return Intl.message(
      'October',
      name: 'month_october',
      desc: '',
      args: [],
    );
  }

  /// `November`
  String get month_november {
    return Intl.message(
      'November',
      name: 'month_november',
      desc: '',
      args: [],
    );
  }

  /// `December`
  String get month_december {
    return Intl.message(
      'December',
      name: 'month_december',
      desc: '',
      args: [],
    );
  }

  /// `App`
  String get settings_title_app {
    return Intl.message(
      'App',
      name: 'settings_title_app',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get settings_title_general {
    return Intl.message(
      'General',
      name: 'settings_title_general',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settings_language {
    return Intl.message(
      'Language',
      name: 'settings_language',
      desc: '',
      args: [],
    );
  }

  /// `Daemon`
  String get settings_daemon {
    return Intl.message(
      'Daemon',
      name: 'settings_daemon',
      desc: '',
      args: [],
    );
  }

  /// `Service Nodes`
  String get settings_service_nodes {
    return Intl.message(
      'Service Nodes',
      name: 'settings_service_nodes',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get settings_dark_theme {
    return Intl.message(
      'Dark Theme',
      name: 'settings_dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get settings_light_theme {
    return Intl.message(
      'Light Theme',
      name: 'settings_light_theme',
      desc: '',
      args: [],
    );
  }

  /// `No route defined for {name}`
  String error_router_no_route(Object name) {
    return Intl.message(
      'No route defined for $name',
      name: 'error_router_no_route',
      desc: '',
      args: [name],
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

  /// `You are already monitoring that node`
  String get error_you_are_already_monitoring {
    return Intl.message(
      'You are already monitoring that node',
      name: 'error_you_are_already_monitoring',
      desc: '',
      args: [],
    );
  }

  /// `Daemon port can only contain numbers between 0 and 65535`
  String get error_text_daemon_port {
    return Intl.message(
      'Daemon port can only contain numbers between 0 and 65535',
      name: 'error_text_daemon_port',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid iPv4 address or domain name`
  String get error_text_daemon_address {
    return Intl.message(
      'Please enter a valid iPv4 address or domain name',
      name: 'error_text_daemon_address',
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
      Locale.fromSubtags(languageCode: 'de'),
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
