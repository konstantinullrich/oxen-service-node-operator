// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de';

  static m0(name) => "Für ${name} ist keine Route definiert";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add_daemon" : MessageLookupByLibrary.simpleMessage("Daemon hinzufügen"),
    "add_node_to_get_started" : MessageLookupByLibrary.simpleMessage("Füge einen Service Node hinzu um loszulegen."),
    "add_service_node" : MessageLookupByLibrary.simpleMessage("Service Node hinzufügen"),
    "daemon_address" : MessageLookupByLibrary.simpleMessage("Daemon Adresse"),
    "daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon Port"),
    "error_public_key_too_long" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel zu lang"),
    "error_public_key_too_short" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel zu kurz"),
    "error_router_no_route" : m0,
    "error_text_daemon_address" : MessageLookupByLibrary.simpleMessage("Bitte gebe eine valide iPv4 Adresse oder Domain Name ein."),
    "error_text_daemon_port" : MessageLookupByLibrary.simpleMessage("Der Daemon Port kann nur Nummern zwischen 0 und 65535 beinhalten."),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "public_key" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel"),
    "settings_daemon" : MessageLookupByLibrary.simpleMessage("Daemon"),
    "settings_dark_theme" : MessageLookupByLibrary.simpleMessage("Dunkles Farbschema"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Sprache"),
    "settings_light_theme" : MessageLookupByLibrary.simpleMessage("Helles Farbschema"),
    "settings_service_nodes" : MessageLookupByLibrary.simpleMessage("Service Nodes"),
    "settings_title_app" : MessageLookupByLibrary.simpleMessage("App"),
    "settings_title_general" : MessageLookupByLibrary.simpleMessage("Generelle Einstellungen"),
    "title_add_daemon" : MessageLookupByLibrary.simpleMessage("Daemon hinzufügen"),
    "title_add_service_node" : MessageLookupByLibrary.simpleMessage("Service Node hinzufügen"),
    "title_dashboard" : MessageLookupByLibrary.simpleMessage("Dashboard"),
    "title_settings" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Willkommen,\nOXEN Service Node Operator"),
    "welcome_first_line" : MessageLookupByLibrary.simpleMessage("Hier kannst du die Service Nodes überwachen, die du bereibst oder beiträgst.")
  };
}
