extension ShortAddress on String {
  String toShortAddress([int leading = 12]) {
    return '${substring(0, leading)}...${substring(length - 4)}';
  }
}
