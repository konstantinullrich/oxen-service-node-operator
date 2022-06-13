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

  static m0(networkSize, currentHeight) => "${networkSize} Nodes bei Höhe ${currentHeight}";

  static m1(title) => "${title} in die Zwischenablage kopiert";

  static m2(name) => "Für ${name} ist keine Route definiert";

  static m3(nextReward) => "~ in ${nextReward} Blöcken";

  static m4(total) => "Alle ${total} Node(s) sind\nbetriebsbereit";

  static m5(healthyNodes, total) => "${healthyNodes} von ${total} Nodes\nsind betriebsbereit";

  static m6(minutes) => "vor ${minutes} Minuten";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add_daemon" : MessageLookupByLibrary.simpleMessage("Daemon hinzufügen"),
    "add_node_to_get_started" : MessageLookupByLibrary.simpleMessage("Füge einen Service Node hinzu um loszulegen."),
    "add_service_node" : MessageLookupByLibrary.simpleMessage("Service Node hinzufügen"),
    "address" : MessageLookupByLibrary.simpleMessage("Spender"),
    "all_service_nodes" : m0,
    "amount" : MessageLookupByLibrary.simpleMessage("Betrag"),
    "awaiting_contributions" : MessageLookupByLibrary.simpleMessage("Warten auf Beiträge"),
    "blocks" : MessageLookupByLibrary.simpleMessage("Blöcke"),
    "checkpoints" : MessageLookupByLibrary.simpleMessage("Checkpoint Blöcke"),
    "contributors" : MessageLookupByLibrary.simpleMessage("Beiträger"),
    "copied_to_clipboard" : m1,
    "daemon_address" : MessageLookupByLibrary.simpleMessage("Daemon Adresse"),
    "daemon_port" : MessageLookupByLibrary.simpleMessage("Daemon Port"),
    "earned_downtime_blocks" : MessageLookupByLibrary.simpleMessage("Verdiente Downtime Blöcke"),
    "error_name_taken" : MessageLookupByLibrary.simpleMessage("Du hast bereits einen Node mit dem Namen"),
    "error_public_key_too_long" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel zu lang"),
    "error_public_key_too_short" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel zu kurz"),
    "error_router_no_route" : m2,
    "error_text_daemon_address" : MessageLookupByLibrary.simpleMessage("Bitte gebe eine valide iPv4 Adresse oder Domain Name ein."),
    "error_text_daemon_port" : MessageLookupByLibrary.simpleMessage("Der Daemon Port kann nur Nummern zwischen 0 und 65535 beinhalten."),
    "error_you_are_already_monitoring" : MessageLookupByLibrary.simpleMessage("Du überwachst diesen Node bereits"),
    "estimated_reward_block" : m3,
    "health_all_nodes" : m4,
    "health_no_nodes" : MessageLookupByLibrary.simpleMessage("Kein Node ist\nbetriebsbereit!"),
    "health_out_of_nodes" : m5,
    "hours" : MessageLookupByLibrary.simpleMessage("Stunden"),
    "last_reward" : MessageLookupByLibrary.simpleMessage("Letzte\nBelohung"),
    "last_reward_height" : MessageLookupByLibrary.simpleMessage("Letzte Belohungs Höhe"),
    "last_uptime_proof" : MessageLookupByLibrary.simpleMessage("Letzter Uptime Proof"),
    "lokinet_router" : MessageLookupByLibrary.simpleMessage("Lokinet\nRouter"),
    "minutes_ago" : m6,
    "month_april" : MessageLookupByLibrary.simpleMessage("April"),
    "month_august" : MessageLookupByLibrary.simpleMessage("August"),
    "month_december" : MessageLookupByLibrary.simpleMessage("Dezember"),
    "month_february" : MessageLookupByLibrary.simpleMessage("Februar"),
    "month_january" : MessageLookupByLibrary.simpleMessage("Januar"),
    "month_july" : MessageLookupByLibrary.simpleMessage("Juli"),
    "month_june" : MessageLookupByLibrary.simpleMessage("Juni"),
    "month_march" : MessageLookupByLibrary.simpleMessage("März"),
    "month_may" : MessageLookupByLibrary.simpleMessage("Mai"),
    "month_november" : MessageLookupByLibrary.simpleMessage("November"),
    "month_october" : MessageLookupByLibrary.simpleMessage("Oktober"),
    "month_september" : MessageLookupByLibrary.simpleMessage("September"),
    "more" : MessageLookupByLibrary.simpleMessage("Mehr"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "next_reward" : MessageLookupByLibrary.simpleMessage("Nächste Belohnung:"),
    "public_ip" : MessageLookupByLibrary.simpleMessage("IP Adresse"),
    "public_key" : MessageLookupByLibrary.simpleMessage("Öffentlicher Schlüssel"),
    "pulses" : MessageLookupByLibrary.simpleMessage("Pulse Blöcke"),
    "registration_height" : MessageLookupByLibrary.simpleMessage("Registrierungs Höhe"),
    "registration_hf_version" : MessageLookupByLibrary.simpleMessage("Registrierte Hardfork Version"),
    "save_service_node" : MessageLookupByLibrary.simpleMessage("Service Node speichern"),
    "service_node_operator" : MessageLookupByLibrary.simpleMessage("Node Operator"),
    "service_node_version" : MessageLookupByLibrary.simpleMessage("Node Version"),
    "settings_daemon" : MessageLookupByLibrary.simpleMessage("Daemon"),
    "settings_dark_theme" : MessageLookupByLibrary.simpleMessage("Dunkles Farbschema"),
    "settings_language" : MessageLookupByLibrary.simpleMessage("Sprache"),
    "settings_light_theme" : MessageLookupByLibrary.simpleMessage("Helles Farbschema"),
    "settings_service_nodes" : MessageLookupByLibrary.simpleMessage("Service Nodes"),
    "settings_title_app" : MessageLookupByLibrary.simpleMessage("App"),
    "settings_title_general" : MessageLookupByLibrary.simpleMessage("Generelle Einstellungen"),
    "software_versions" : MessageLookupByLibrary.simpleMessage("Node / Storage Server / Lokinet Version"),
    "state_height" : MessageLookupByLibrary.simpleMessage("Letzte Zustandsänderung Höhe"),
    "storage_server" : MessageLookupByLibrary.simpleMessage("Storage\nServer"),
    "success_saved_node" : MessageLookupByLibrary.simpleMessage("Node gespeichert"),
    "swarm_id" : MessageLookupByLibrary.simpleMessage("Swarm ID"),
    "title_add_daemon" : MessageLookupByLibrary.simpleMessage("Daemon hinzufügen"),
    "title_add_service_node" : MessageLookupByLibrary.simpleMessage("Service Node hinzufügen"),
    "title_changelog" : MessageLookupByLibrary.simpleMessage("Changelog"),
    "title_dashboard" : MessageLookupByLibrary.simpleMessage("Dashboard"),
    "title_edit_daemons" : MessageLookupByLibrary.simpleMessage("Daemons bearbeiten"),
    "title_edit_service_node" : MessageLookupByLibrary.simpleMessage("Service Node bearbeiten"),
    "title_edit_service_nodes" : MessageLookupByLibrary.simpleMessage("Service Nodes bearbeiten"),
    "title_settings" : MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "uptime_proof" : MessageLookupByLibrary.simpleMessage("Uptime Proof"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Willkommen,\nOXEN Service Node Operator"),
    "welcome_first_line" : MessageLookupByLibrary.simpleMessage("Hier kannst du die Service Nodes überwachen, die du bereibst oder zu den du beiträgst."),
    "your_service_nodes" : MessageLookupByLibrary.simpleMessage("Deine Service Nodes")
  };
}
