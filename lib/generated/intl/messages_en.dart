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
    "add_node_to_get_started" : MessageLookupByLibrary.simpleMessage("Add a Service Node below to get started."),
    "add_service_node" : MessageLookupByLibrary.simpleMessage("Add a Service Node"),
    "add_service_node_title" : MessageLookupByLibrary.simpleMessage("Add Service Node"),
    "error_public_key_too_long" : MessageLookupByLibrary.simpleMessage("Public Key too long"),
    "error_public_key_too_short" : MessageLookupByLibrary.simpleMessage("Public Key too short"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "public_key" : MessageLookupByLibrary.simpleMessage("Public Key"),
    "router_no_route" : m0,
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome,\nOXEN Service Node Operator"),
    "welcome_first_line" : MessageLookupByLibrary.simpleMessage("Here you can watch Service Nodes you run or contributed to.")
  };
}
