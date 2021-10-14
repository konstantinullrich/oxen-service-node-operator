import 'package:hive/hive.dart';
import 'package:oxen_service_node/src/oxen/service_node.dart';

enum KeyValidity {
  CORRECT,
  TOO_LONG,
  TOO_SHORT
}

KeyValidity isValidPublicKey(String publicKey) {
  if (publicKey.length == 64) return KeyValidity.CORRECT;
  if (publicKey.length < 64) return KeyValidity.TOO_LONG;
  return KeyValidity.TOO_SHORT;
}
