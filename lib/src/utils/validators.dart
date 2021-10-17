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
