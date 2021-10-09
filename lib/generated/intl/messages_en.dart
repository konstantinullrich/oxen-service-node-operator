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

  static m0(title) => "Copied ${title} to clipboard";

  static m1(name) => "No route defined for ${name}";

  static m4(unlockBlock) => "in ${unlockBlock} Blocks";

  static m2(nextReward) => "~ in ${nextReward} Blocks";

  static m3(healthyNodes, total) => "${healthyNodes} out of ${total} nodes\nare operational";

  static m5(total) => "All ${total} node(s) operational";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add_daemon" : MessageLookupByLibrary.simpleMessage("Add Daemon"),
    "add_node_to_get_started" : MessageLookupByLibrary.simpleMessage("Add a Service Node below to get started."),
    "add_service_node" : MessageLookupByLibrary.simpleMessage("Add a Service Node"),
    "copied_to_clipboard" : m0,
    "daemon_address" : MessageLookupByLibrary.simpleMessage("Daemon Address"),
    "daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon Port"),
    "earned_downtime_blocks" : MessageLookupByLibrary.simpleMessage("Earned Downtime Blocks"),
    "error_public_key_too_long" : MessageLookupByLibrary.simpleMessage("Public Key too long"),
    "error_public_key_too_short" : MessageLookupByLibrary.simpleMessage("Public Key too short"),
    "error_router_no_route" : m1,
    "error_text_daemon_address" : MessageLookupByLibrary.simpleMessage("Please enter a valid iPv4 address or domain name"),
    "error_text_daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon port can only contain numbers between 0 and 65535"),
    "error_you_are_already_monitoring" : MessageLookupByLibrary.simpleMessage("You are already monitoring that node"),
    "estimated_node_unlock" : m4,
    "estimated_reward_block" : m2,
    "health_all_nodes" : m5,
    "health_no_nodes" : MessageLookupByLibrary.simpleMessage("No nodes are operational!"),
    "health_out_of_nodes" : m3,
    "last_reward" : MessageLookupByLibrary.simpleMessage("Last Reward"),
    "last_reward_height" : MessageLookupByLibrary.simpleMessage("Last Reward Height"),
    "last_uptime_proof" : MessageLookupByLibrary.simpleMessage("Last Uptime Proof"),
    "month_april" : MessageLookupByLibrary.simpleMessage("April"),
    "month_august" : MessageLookupByLibrary.simpleMessage("August"),
    "month_december" : MessageLookupByLibrary.simpleMessage("December"),
    "month_february" : MessageLookupByLibrary.simpleMessage("February"),
    "month_january" : MessageLookupByLibrary.simpleMessage("January"),
    "month_july" : MessageLookupByLibrary.simpleMessage("July"),
    "month_june" : MessageLookupByLibrary.simpleMessage("June"),
    "month_march" : MessageLookupByLibrary.simpleMessage("March"),
    "month_may" : MessageLookupByLibrary.simpleMessage("May"),
    "month_november" : MessageLookupByLibrary.simpleMessage("November"),
    "month_october" : MessageLookupByLibrary.simpleMessage("October"),
    "month_september" : MessageLookupByLibrary.simpleMessage("September"),
    "more" : MessageLookupByLibrary.simpleMessage("More"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "next_reward" : MessageLookupByLibrary.simpleMessage("Next Reward:"),
    "public_key" : MessageLookupByLibrary.simpleMessage("Public Key"),
    "registration_height" : MessageLookupByLibrary.simpleMessage("Registration Height"),
    "registration_hf_version" : MessageLookupByLibrary.simpleMessage("Registration Hardfork Version"),
    "service_node_operator" : MessageLookupByLibrary.simpleMessage("Node Operator"),
    "service_node_version" : MessageLookupByLibrary.simpleMessage("Node Version"),
    "settings_daemon" : MessageLookupByLibrary.simpleMessage("Daemon"),
    "settings_dark_theme" : MessageLookupByLibrary.simpleMessage("Dark Theme"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Language"),
    "settings_light_theme" : MessageLookupByLibrary.simpleMessage("Light Theme"),
    "settings_service_nodes" : MessageLookupByLibrary.simpleMessage("Service Nodes"),
    "settings_title_app" : MessageLookupByLibrary.simpleMessage("App"),
    "settings_title_general" : MessageLookupByLibrary.simpleMessage("General"),
    "storage_server" : MessageLookupByLibrary.simpleMessage("Storage Server"),
    "swarm_id" : MessageLookupByLibrary.simpleMessage("Swarm ID"),
    "title_add_daemon" : MessageLookupByLibrary.simpleMessage("Add Daemon"),
    "title_add_service_node" : MessageLookupByLibrary.simpleMessage("Add Service Node"),
    "title_dashboard" : MessageLookupByLibrary.simpleMessage("Dashboard"),
    "title_edit_daemons" : MessageLookupByLibrary.simpleMessage("Edit Daemons"),
    "title_edit_service_node" : MessageLookupByLibrary.simpleMessage("Edit Service Nodes"),
    "title_settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "unlocking_node" : MessageLookupByLibrary.simpleMessage("Node is unlocking"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome,\nOXEN Service Node Operator"),
    "welcome_first_line" : MessageLookupByLibrary.simpleMessage("Here you can watch Service Nodes you run or contribute to."),
    "your_service_nodes" : MessageLookupByLibrary.simpleMessage("Your Service Nodes")
  };
}
