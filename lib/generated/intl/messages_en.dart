// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(name) => "No route defined for ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add_daemon" : MessageLookupByLibrary.simpleMessage("Add Daemon"),
    "add_node_to_get_started" : MessageLookupByLibrary.simpleMessage("Add a Service Node below to get started."),
    "add_service_node" : MessageLookupByLibrary.simpleMessage("Add a Service Node"),
    "daemon_address" : MessageLookupByLibrary.simpleMessage("Daemon Address"),
    "daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon Port"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "error_public_key_too_long" : MessageLookupByLibrary.simpleMessage("Public Key too long"),
    "error_public_key_too_short" : MessageLookupByLibrary.simpleMessage("Public Key too short"),
    "error_router_no_route" : m0,
    "error_text_daemon_address" : MessageLookupByLibrary.simpleMessage("Please enter a valid iPv4 address or domain name"),
    "error_text_daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon port can only contain numbers between 0 and 65535"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "public_key" : MessageLookupByLibrary.simpleMessage("Public Key"),
    "settings_daemon" : MessageLookupByLibrary.simpleMessage("Daemon"),
    "settings_dark_theme" : MessageLookupByLibrary.simpleMessage("Dark Theme"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_light_theme" : MessageLookupByLibrary.simpleMessage("Light Theme"),
    "settings_service_nodes" : MessageLookupByLibrary.simpleMessage("Service Nodes"),
    "settings_title_app" : MessageLookupByLibrary.simpleMessage("App"),
    "settings_title_general" : MessageLookupByLibrary.simpleMessage("General"),
    "title_add_daemon" : MessageLookupByLibrary.simpleMessage("Add Daemon"),
    "title_add_service_node" : MessageLookupByLibrary.simpleMessage("Add Service Node"),
    "title_dashboard" : MessageLookupByLibrary.simpleMessage("Dashboard"),
    "title_edit_daemons" : MessageLookupByLibrary.simpleMessage("Edit Daemons"),
    "title_edit_service_node" : MessageLookupByLibrary.simpleMessage("Edit Service Nodes"),
    "title_settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome,\nOXEN Service Node Operator"),
    "welcome_first_line" : MessageLookupByLibrary.simpleMessage("Here you can watch Service Nodes you run or contributed to.")
  };
}
