class Contributor {
  Contributor(this.address, this.amount, this.reserved);

  Contributor.fromMap(Map map)
      : address = (map['address'] ?? '') as String,
        amount = (map['amount'] ?? 0) as int,
        reserved = (map['reserved'] ?? 0) as int;

  final String address;
  final int amount;
  final int reserved;
}
